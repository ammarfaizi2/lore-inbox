Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271651AbRHQNV6>; Fri, 17 Aug 2001 09:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271653AbRHQNVr>; Fri, 17 Aug 2001 09:21:47 -0400
Received: from [200.156.3.116] ([200.156.3.116]:17393 "EHLO
	office.extracta.com.br") by vger.kernel.org with ESMTP
	id <S271651AbRHQNV1>; Fri, 17 Aug 2001 09:21:27 -0400
Message-ID: <3B7D1B52.3070606@extracta.com.br>
Date: Fri, 17 Aug 2001 10:25:38 -0300
From: Jon Lapham <lapham@extracta.com.br>
Reply-To: lapham@extracta.com.br
Organization: Extracta Moleculas Naturais
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010807
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange SCSI behavior?
In-Reply-To: <9678C2B4D848D41187450090276D1FAE1008EAF7@FMSMSX32>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew-

I don't know if this helps, but this is the message tar spits out when 
this problem occurs:

/bin/tar: home/pedro/COL&AMk-TA: Read error at byte 21958656, reading 
10240 byte: Input/output error

Cress, Andrew R wrote:
> Jon,
> 
> You really need to know what the additional sense data shows.
> With DAT tapes often they have variable length block sizes and get errors
> from some UNIX commands as a result.  Or, it may be something that could be
> fixed with a firmware update to the DAT drive, or a driver fix.  It depends
> on the details.  Is sd08:11 the DAT drive?

Hmmm... I have no idea!  I know that "host 0 channel 0 id 1 lun 0" 
refers to the new Atlas HD, and I know that I have another HD with id 0, 
and that the tape drive is id 3.  I do not know how to interpret 
"sd08:11", suggestions?

Maybe 'sd08' refers to the block device number?
[root@office sysadm]# cat /proc/devices
[snip]
Block devices:
   2 fd
   7 loop
   8 sd
  22 ide1
  65 sd
  66 sd

So, one of the three SCSI devices uses block 8... but which?  I don't know.

> 
> Make sure 
> CONFIG_SCSI_LOGGING=y 
> CONFIG_SCSI_DEBUG=m (or =y)
> in your kernel, and issue
> echo "scsi log error 3" > /proc/scsi/scsi
> and rerun the tape backup to get more info.
> 
> Andy
> 


Okay, good idea.  I will recompile setting those symbols, but I will not 
be able to do so until after the machine is idle (>5PM tonight).  BTW, 
these are my current SCSI symbol defs:

CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000


