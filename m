Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293516AbSBZEpe>; Mon, 25 Feb 2002 23:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293513AbSBZEpZ>; Mon, 25 Feb 2002 23:45:25 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:32517 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S293511AbSBZEpS>; Mon, 25 Feb 2002 23:45:18 -0500
Message-ID: <3C7B12DD.264A7AE4@delusion.de>
Date: Tue, 26 Feb 2002 05:45:17 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-net <linux-net@vger.kernel.org>
Subject: Re: mmapped packet socket queueing tcp packets twice?
In-Reply-To: <3C7B06ED.8EC55523@delusion.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> Feb 26 04:41:56 Kerberos ipacctd: [Slot 4] Incoming TCP - Len:  136 Sum: 72b7 [1014694916.161277]
> Feb 26 04:41:56 Kerberos ipacctd: [Slot 5] Incoming TCP - Len:  136 Sum: 72b7 [1014694916.161592]

I think I've figured out what is happening. The first copy of the packet is of type 4 (outgoing)
and the second copy is of type 3 (otherhost). We are using an fddi ring here, so what seems to
happen is this:

The station running the program with a packet socket sends out a network packet to some other
host and the packet socket gets a copy of the packet with type "outgoing".
This is what I'd expect.

However, once the packet has been around the fddi ring, the originating host receives it again,
and then passes it back to the packet socket as "otherhost", which is of course not wrong,
because the destination is indeed another host, but the source host is the station itself,
and it seems quite awkward that the packet socket regards this packet as "otherhost"
and sees it twice. Shouldn't it look at the source address too?

Comments?

-Udo.
