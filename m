Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292579AbSBZDyp>; Mon, 25 Feb 2002 22:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292605AbSBZDyg>; Mon, 25 Feb 2002 22:54:36 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:22789 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S292579AbSBZDyW>; Mon, 25 Feb 2002 22:54:22 -0500
Message-ID: <3C7B06ED.8EC55523@delusion.de>
Date: Tue, 26 Feb 2002 04:54:21 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-net <linux-net@vger.kernel.org>
Subject: mmapped packet socket queueing tcp packets twice?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

While playing around with packet sockets I stumbled across the following strange
thing:

Feb 26 04:41:56 Kerberos ipacctd: [Slot 4] Incoming TCP - Len:  136 Sum: 72b7 [1014694916.161277] 
Feb 26 04:41:56 Kerberos ipacctd: [Slot 5] Incoming TCP - Len:  136 Sum: 72b7 [1014694916.161592] 
Feb 26 04:41:56 Kerberos ipacctd: [Slot 9] Incoming TCP - Len:  120 Sum: 81b7 [1014694916.168418] 
Feb 26 04:41:56 Kerberos ipacctd: [Slot 10] Incoming TCP - Len:  120 Sum: 81b7 [1014694916.168687]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 12] Incoming TCP - Len:  120 Sum: 80b7 [1014694916.170024]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 13] Incoming TCP - Len:  120 Sum: 80b7 [1014694916.170283]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 15] Incoming TCP - Len:  120 Sum: 7fb7 [1014694916.171432]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 16] Incoming TCP - Len:  120 Sum: 7fb7 [1014694916.171681]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 18] Incoming TCP - Len:  120 Sum: 7eb7 [1014694916.172807]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 19] Incoming TCP - Len:  120 Sum: 7eb7 [1014694916.173094]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 21] Incoming TCP - Len:  120 Sum: 7db7 [1014694916.174245]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 22] Incoming TCP - Len:  120 Sum: 7db7 [1014694916.174499]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 24] Incoming TCP - Len:  120 Sum: 7cb7 [1014694916.176289]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 25] Incoming TCP - Len:  120 Sum: 7cb7 [1014694916.176562]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 30] Incoming TCP - Len:  136 Sum: 6bb7 [1014694916.182037]
Feb 26 04:41:56 Kerberos ipacctd: [Slot 31] Incoming TCP - Len:  136 Sum: 6bb7 [1014694916.182308]
                                      ^                                 ^              ^ 
                                      |                                 |              |
                                  Ring Slot                          Checksum      Timestamp

The program runs under Linux-2.4.17 on machine A and looks for packets of type PACKET_OTHERHOST
coming from and going to machine B. For all incoming tcp traffic of machine B, each packet appears
in the mmapped packet ring twice. The ring slots are adjacent and the checksum is the same.
Only the timestamps differ slightly.

Can someone explain this behaviour?

-Udo.
