Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbRF2VbD>; Fri, 29 Jun 2001 17:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbRF2Vay>; Fri, 29 Jun 2001 17:30:54 -0400
Received: from cpe-66-1-45-23.az.sprintbbd.net ([66.1.45.23]:10257 "EHLO
	deming-os.org") by vger.kernel.org with ESMTP id <S261425AbRF2Vaf>;
	Fri, 29 Jun 2001 17:30:35 -0400
Message-ID: <3B3CF50E.65D24882@deming-os.org>
Date: Fri, 29 Jun 2001 14:37:18 -0700
From: Tom spaziani <digiphaze@deming-os.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Module tracing.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently been laboring over a kernel module that allows other
kernel modules to send messages
and tracing statements.  If anyone has any input on whether this would
be a usefull thing or not
please let me know. Here is a quick breakdown on how it works.

Beware, this is only a BRIEF explaination.. I'll follow up with more
details if anyone is intereasted.

trace.o  <- Tracing module
mymodule .o  <-  Client module

1: Load tracing module
2: Load a module that uses the tracing modules for reporting.
    a. the client module requests a certain number of reporting levels.
    b. the trace module creates a devFS entry for each of the requested
reporting levels.
                    ( /dev/trace/mymodule/mymodule0
                                                          mymodule1 ...
)
3. Now the client module can send messages with a specific severity
rating and have it set
    to the appropriate character file.
4. User space programs listening on each of the character files can do
whatever, log the messages
    or perform tasks depending on the message.
5. When a client module is unloaded the devFS entries are removed and
the user programs are also
    told to close the file.

I am using the devFS filesystem because of the abilities to easily
dynamically create new entries and
remove them..  Currently devFS does not recycle Major and Minor numbers,
but a co-worker of mine
has created a patch to fix that.

