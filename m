Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTIWQ4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTIWQ4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:56:10 -0400
Received: from ivimey.org ([194.106.52.201]:18219 "EHLO ivimey.org")
	by vger.kernel.org with ESMTP id S261586AbTIWQ4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:56:07 -0400
Date: Tue, 23 Sep 2003 17:56:01 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@gatemaster.ivimey.org
To: Andrea Arcangeli <andrea@suse.de>
cc: Jan Evert van Grootheest <j.grootheest@euronext.nl>,
       Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: log-buf-len dynamic
In-Reply-To: <20030923154137.GA1265@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0309231748310.27885-100000@gatemaster.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -1.4 (-)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003, Andrea Arcangeli wrote:

>On Tue, Sep 23, 2003 at 05:01:26PM +0200, Jan Evert van Grootheest wrote:
>> I think it is pretty senseless to have a configuation option for the 
>> default size of that buffer. Especially if I can, in one of the first rc 
>> scripts, do something like 'echo 128 > /proc/sys/kernel/printkbuffer'.
>
>having a sysctl can be an additional option (though it's tricky to
>implement due the needed callbacks), but the problem I guess is that
>most people needs a larger buf for the boot logs, so having only the
>sysctl would be too late...

IMO there are two issues:

1. On some systems it is possible to overflow the log buffer during boot and 
before init runs

2. On some systems, there is enough going on that klogd cannot read the log 
quick enough and so the log is missing lines.

IME (1) is the irritating one. I can (and have) edited the source, but it is 
irritating.  Setting up the config option is ok, but for default kernels (e.g. 
a distro one) where you can't easily recompile, it's insufficient.


Proposal:

1. The default buffer size is huge: 128K or more, which should enable the 
initial mesages to be kept.

2. The default buffer size is modifiable on the command line, but does not 
have to be set there (mainly for those with v. limited RAM).

3. The log buffer can be resized smaller and bigger: using sysctl seems nice, 
but might a dmesg option be ok?

4. klogd and dmesg, at all times, can tell how big the buffer is and where the 
start and end are. That is, there is no need for the user to tell dmesg how 
big the buffer is.

5. Lets just do something and move on: it's not important enough to waste 
weeks talking about :-)

HTH,

Ruth


-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

