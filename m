Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289305AbSAVVDR>; Tue, 22 Jan 2002 16:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289306AbSAVVC5>; Tue, 22 Jan 2002 16:02:57 -0500
Received: from CPE0000d400a7cc.cpe.net.cable.rogers.com ([24.156.80.5]:16894
	"HELO bits.dyndns.org") by vger.kernel.org with SMTP
	id <S289305AbSAVVCy> convert rfc822-to-8bit; Tue, 22 Jan 2002 16:02:54 -0500
Date: 22 Jan 2002 21:02:52 -0000
Message-ID: <20020122210252.12485.qmail@bits.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Subject: Re: Possible Idea with filesystem buffering.
To: linux-kernel@vger.kernel.org
From: Rolf Lear <rolf-linux@bits.dyndns.org>
Cc: Rik van Riel <riel@conectiva.com.br>, reiser@namesys.com
In-Reply-To: %3C3C4DCC49.1080202%40namesys.com%3E%20from%20Hans%20Reiser%20on%20Tue%2C%0A%20%20%20%2022%20Jan%202002%2023%3A32%3A09%20%2B0300%0A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me for being a kernel newbie (and a list lurker), and for simplifying what is obviously a complex issue... but ... the underlying issue really is simple. Further, you are both suggesting that a change in design is not out-of-the-question.

The VM is responsible for making sure that Mem is used efficiently. The FS is responsible for making sure that the disks (both space and speed) are used efficiently.

Now, I have followed this thread for days, and I agree with Rik that the VM should be able to tell (command) the FS to free a page. I agree with Hans that "Ideally", the VM should be capable of identifying the best page to free (in terms of cost to the FS). In this ideal world, it is the responsibility of an intelligent FS to inform an intelligent VM what it can do quickly, and what will take time.

What I propose is either:
a) An indication on each dirty page the cost required to clean it.
b) A FS function which can be called which indicates the cost of a clean.

This cost should be measured in terms of something relevant like approximate IO time. FS's which do not support this system should have stubs which cost all pages equally.

The system would work as follows:
VM Needs to free some Mem, and not enough clean pages can be freed.
VM Identifies those dirty pages which are cheap to flush/clean, and does it. If VM Needs to flush an expensive page, it can still do it, but it knows whe price ahead of time (double bonus).

To identify the cheap pages, the VM can ask the FS the price, and as an added bonus, the FS can tell the VM how many other pages will get freed in the process.

In my world of client-server / databases / etc, this just makes sense. 

If this intelligent VM has a basic FS, it looses nothing. If it has an intelligent FS, it has more information to make better decisions.

Rolf
