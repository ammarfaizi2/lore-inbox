Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTESCKg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 22:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbTESCKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 22:10:35 -0400
Received: from Kona.Carleton.edu ([137.22.93.220]:29371 "EHLO
	kona.carleton.edu") by vger.kernel.org with ESMTP id S262306AbTESCKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 22:10:34 -0400
Date: Sun, 18 May 2003 21:23:45 -0500
From: Ethan Sommer <sommere@ethanet.com>
Subject: [ANNOUNCE] Layer-7 Filter for Linux QoS
To: linux-kernel@vger.kernel.org
Message-id: <3EC84031.90300@ethanet.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030515
 Thunderbird/0.1a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have written a filter for the QoS infrastructure that looks at the 
data segment of packets and uses regular expressions to identify the 
protocol of a stream of traffic regardless of port number.

Many peer-to-peer programs (such as Kazaa and Gnucleus) will change to 
use a different port (including well known ports such as, say, 80) if 
they find that they can get better throughput there. That means that the 
port based filtering is no longer sufficient. However, by analyzing the 
application layer data, we can differentiate Kazaa from non-Kazaa HTTP, 
and lower the priority of whichever we deem to be less important. :)

It is a filter in the existing QoS infrastructure, so it can be used in 
conjunction with u32 filters, HTB or CBQ scheduling, SFQ queueing etc, 
etc...

Commercial companies sell devices which do layer-7 classification for 
anywhere from $6000-$80,000 depending on the bandwidth required. If we 
can build a comprehensive set of patterns I don't see any reason why 
Linux can't beat the pants off the commercial devices; we already have 
excellent queueing, and scheduling.

Our home page is http://l7-filter.sourceforge.net/ but if you want to 
skip right to the downloads go to 
http://sourceforge.net/projects/l7-filter/ (there is a kernel patch, a 
patched version of tc, and some sample patterns for HTTP, POP3, IMAP, 
SSH, Kazaa, and FTP.) You'll notice the patch is a somewhat large, most 
of that is regexp code.

We're still working on it. It currently only does TCP for example... Do 
you guys/gals have any comments/suggestions/etc? I suspect that this is 
a post 2.6 thing, but it is very non-invasive (it only adds approx. 2 
lines of code that would affect anything if the user were not using the 
layer-7 filters,) so I still have a little bit of hope.

Ethan Sommer
Matt Strait
Justin Levandoski

