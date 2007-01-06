Return-Path: <linux-kernel-owner+w=401wt.eu-S932113AbXAFTzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbXAFTzJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbXAFTzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:55:08 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:47732 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113AbXAFTzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:55:07 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <459FFE95.1020403@s5r6.in-berlin.de>
Date: Sat, 06 Jan 2007 20:55:01 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3 regression?  hdparm shows 1/2...1/3 the throughput
References: <459FE2AF.2020507@s5r6.in-berlin.de> <Pine.LNX.4.63.0701062018530.29044@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.63.0701062018530.29044@gockel.physik3.uni-rostock.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
> On Sat, 6 Jan 2007, Stefan Richter wrote:
> 
>> Did anybody else notice this?  The result of "hdparm -t" under 2.6.20-rc
>> seems to be less than half of what you get on 2.6.19.  However, disk I/O
>> did *not* get slower according to bonnie++.
> 
> yes. See
>   http://lkml.org/lkml/2007/1/2/75
> for the solution.
> 
> Tim

Thanks. I should have remembered that.

# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   10864 MB in  2.00 seconds = 5440.10 MB/sec
 Timing buffered disk reads:   58 MB in  3.06 seconds =  18.94 MB/sec
# cat /sys/block/hda/queue/scheduler
noop anticipatory deadline [cfq]
# echo anticipatory > /sys/block/hda/queue/scheduler
# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   10680 MB in  2.00 seconds = 5347.20 MB/sec
 Timing buffered disk reads:  148 MB in  3.02 seconds =  49.03 MB/sec

-- 
Stefan Richter
-=====-=-=== ---= --==-
http://arcgraph.de/sr/
