Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbVIIHed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbVIIHed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVIIHed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:34:33 -0400
Received: from port-212-202-160-2.static.qsc.de ([212.202.160.2]:19474 "EHLO
	imr-mail.intra.in-medias-res.com") by vger.kernel.org with ESMTP
	id S1751425AbVIIHec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:34:32 -0400
Message-ID: <43213B7E.9050207@in-medias-res.com>
Date: Fri, 09 Sep 2005 09:36:30 +0200
From: =?ISO-8859-15?Q?sch=F6nfeld_/_in-medias-res?= 
	<schoenfeld@in-medias-res.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
References: <S932080AbVIGI45/20050907085657Z+286@vger.kernel.org>	 <431ECA16.8040104@in-medias-res.com> <1126095079.28456.18.camel@imp.csi.cam.ac.uk> <431EF5CD.9050006@in-medias-res.com> <431F143F.2070904@vc.cvut.cz>
In-Reply-To: <431F143F.2070904@vc.cvut.cz>
X-Enigmail-Version: 0.92.0.0
X-SA-Exim-Connect-IP: 192.168.2.172
X-SA-Exim-Mail-From: schoenfeld@in-medias-res.com
Subject: Re: ncpfs: Connection invalid / Input-/Output Errors
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.499997, version=0.92.1
   int  cnt   prob  spamicity histogram
  0.00   12 0.015028 0.009025 ############
  0.10    0 0.000000 0.009025 
  0.20    0 0.000000 0.009025 
  0.30    0 0.000000 0.009025 
  0.40    0 0.000000 0.009025 
  0.50    0 0.000000 0.009025 
  0.60    0 0.000000 0.009025 
  0.70    0 0.000000 0.009025 
  0.80    0 0.000000 0.009025 
  0.90   10 0.992021 0.492503 ##########
X-SA-Exim-Version: 4.0 (built Mon, 19 Jul 2004 17:01:11 +0200)
X-SA-Exim-Scanned: Yes (on imr-mail.intra.in-medias-res.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Petr Vandrovec schrieb:
> Enable displaying of connection watchdog logouts on the server.  Do not
> use 'intr' mount option.  Do not send KILL signal to the connection
> which is waiting for reply from server.  If you are not sure that your
> network infrastructure is fine, use 'hard' mount option to disable
> timeouts altogether.

well, the thing with KILL signals is something i found after reading
your email. You did write that to another person a while ago. Now i
found that i missed a thing when i looked for differences between the two
server and got a suspicion on my mind. The only real difference between
the two servers is that the one with the problems does run a nagios nrpe
server and some plugins, e.g. to check disk space on the novell disk,
while the other server does not. Now i found that heavy operations on
the filesystem (e.g. stat'ing many small files in a short time) is a
kind of problematic, if you want to do anything else on the filesystem
at the same time. The second process just hangs until the first one
accessing the ncp filesystem is ready with its operation. Well if
nagios pretends to run a check it does send a request to the nrpe
server, which will start a plugin to check what it has to check.
Now the problem is, that the plugin will not return a result until
the timeout (i'm quiet sure that one exists) exceeds. The only
question now is: Does NRPE Server send a SIGKILL to the plugin when time
out exceeds? I'll try that. Maybe the dog lies buried there.

For now: Thanks for your help. I'll try that first and then eventually
the printk-thing.

> Into 'ncp_invalidate_conn()', or better, into its callers.  One is in
> __abort_ncp_connection (invoked for IPX connections when
> __ncpdgram_timeout_proc fires), second is in ncp_do_request (if server
> reports some problem, or if KILL signal is sent to the process).

Ok, thanks.

Greets
Patrick
