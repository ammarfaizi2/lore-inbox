Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270543AbUJTWSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270543AbUJTWSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270374AbUJTWNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:13:41 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:61160 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S270549AbUJTWMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:12:37 -0400
Message-ID: <4176E2BE.5070806@nortelnetworks.com>
Date: Wed, 20 Oct 2004 16:12:14 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <cl6lfq$jlg$1@terminus.zytor.com> <4176DF84.4050401@nortelnetworks.com> <4176E001.1080104@zytor.com>
In-Reply-To: <4176E001.1080104@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> Doing work twice can hardly be considered The Right Thing.

If the alternative is to have apps that can be DOS'd with a single corrupt 
packet, I think that yes, it is.

Going forward, all apps should use nonblocking sockets, correct?  (With the 
current design, because it's the only way to get correctness, with my proposal 
because it's the only way to get full speed.)

Given that, we then have to worry about the installed base of binaries out there 
that will use blocking sockets.  And it's going to take some time before they 
all convert.  For all those binaries, (which include basic things like syslog, 
inetd, portmap, and statd) the existing kernel behaviour does not match what the 
app is expecting.  With a minor change, we can give the behaviour that the app 
expects, though at a performance penalty.  Once the app switches over to 
nonblocking sockets (which it has to do *anyway* under the current model) then 
it gets full performance.

To summarize:
1) apps have to switch to nonblocking sockets  (for correctness)
2) my proposal makes them work as expected in the meantime, with a performance cost


Chris
