Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUDAAoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 19:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUDAAoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 19:44:37 -0500
Received: from bay2-f51.bay2.hotmail.com ([65.54.247.51]:22537 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261358AbUDAAof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 19:44:35 -0500
X-Originating-IP: [209.172.74.2]
X-Originating-Email: [idht4n@hotmail.com]
From: "David L" <idht4n@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: serial port canonical mode weirdness?
Date: Wed, 31 Mar 2004 16:44:32 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F51LDp7mvjkO2200021e67@hotmail.com>
X-OriginalArrivalTime: 01 Apr 2004 00:44:32.0832 (UTC) FILETIME=[7FAB0C00:01C41782]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I configure a serial port for canonical mode (newtio.c_lflag = ICANON),
I get behavior that isn't what I'd expect.  If I send >4095 characters that 
don't
contain an end-of-line and then an end of line, the number of characters 
read
is 1.  If I then start sending shorter lines, one character is read for each
end-of-line that is sent.  For example, if the limit was 10 instead of 4096, 
if the
received data was:

0123456789\n

The data returned by the driver would be:

0

(I would expect 0123456789\n to be returned)

Then if you send "A\n"
The data returned will be "1"

Then if you send "B\n"
The data returned will be "2"

And so on.

When it's in this state and you send "\n\n", it returns 4096 characters
and then starts acting like I would expect again.

I've also found that when it's in this state and you send
a few lines in rapid succession, the call to read will return 0
bytes and never returns any more good data.

Is this a kernel bug or an ignorant user?  I might expect some
data to be lost if a buffer overruns, but I didn't expect this behavior.

Thanks:

                                           David

_________________________________________________________________
MSN Toolbar provides one-click access to Hotmail from any Web page – FREE 
download! http://toolbar.msn.com/go/onm00200413ave/direct/01/

