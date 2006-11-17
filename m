Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755949AbWKQVqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949AbWKQVqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755950AbWKQVqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:46:14 -0500
Received: from hera.kernel.org ([140.211.167.34]:52382 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1755949AbWKQVqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:46:13 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Read/Write multiple network FDs in a single syscall context
 switch?
Date: Fri, 17 Nov 2006 13:45:29 -0800
Organization: OSDL
Message-ID: <20061117134529.544d67b9@freekitty>
References: <5A09CDB9FC09B1478DF679F4C698D1DB5CA2D5@johnleehooker.bluenote.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Trace: build.pdx.osdl.net 1163799929 30565 10.8.0.54 (17 Nov 2006 21:45:29 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 17 Nov 2006 21:45:29 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by hera.kernel.org id kAHLjcHt013720
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 16:40:30 -0500
"Marc Snider" <msnider@bluenotenetworks.com> wrote:

> I've searched long and hard prior to posting here, but have been unable to locate a kernel mechanism providing the ability to read or write multiple FDs in a single userspace to kernel context switch.
> 
> We've got a userspace network application that uses epoll to wait for packet arrival and then reads a single frame off of dozens of separate FDs (sockets), operates on the payload and then forwards along by writing to dozens of other separate FDs (sockets).   At high loads we invariably have many dozens of socket FDs to read and write.
> 
> If 50 separate frames are received on 50 separate sockets then we are at present doing 50 separate reads and then 50 separate writes, thus resulting in over a hundred distinct (and seemingly unnecessary) user to kernel space and kernel to user space context switches.   Is there a mechanism I've missed which allows many network FDs to be read or written in a single syscall?   For example, something analogous to the recv() and send() calls but instead providing a vector for the parameters and return value?
> 
> I picture something like:
> 
>      ssize_t *recvMultiple(int *s, void **buf, size_t *len, int *flags)         and
>      ssize_t *sendMultiple(int *s, void **buf, size_t *len, int *flags)
> 
> 
> The user would have to be careful about not using blocking sockets with these types of multiple FD operations, but it seems to me that such a kernel mechanism would allow a user space process to eliminate dozens or even hundreds of unnecessary context switches when servicing multiple network FDs...    The cycle savings for an application like ours would be huge.   I am confused about why I've been unable to locate such a mechanism considering the perceived performance advantages and ubiquitous nature of user applications that service many network FDs...
> 
> If it's not too much trouble then I'd appreciate if those answering could CC: me on any responses.
> 
> 
> Regards,
> 
> Marc Snider
> msnider@bluenotenetworks.com


No there is no API like this. You will have all sorts of problems to consider like
what if there is no data on some of the sockets, or you are flow blocked or lots of
other issues. If the data is all the same then why not use multicast?


-- 
Stephen Hemminger <shemminger@osdl.org>

