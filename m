Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272475AbRINNib>; Fri, 14 Sep 2001 09:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273389AbRINNiX>; Fri, 14 Sep 2001 09:38:23 -0400
Received: from hermes.domdv.de ([193.102.202.1]:59922 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272475AbRINNiP>;
	Fri, 14 Sep 2001 09:38:15 -0400
Message-ID: <XFMail.20010914153738.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BA2021F.488F65F8@t-online.de>
Date: Fri, 14 Sep 2001 15:37:38 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: <SPATZ1@t-online.de (Frank Schneider)>
Subject: Re: AIC7xxx errors in 2.2.19 but not in 2.2.18
Cc: linux-kernel@vger.kernel.org, Holger Kiehl <Holger.Kiehl@dwd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
2.2.19 only has the 'old' driver. The 'raid/scsi new' problem is a notifier
chain sequence problem that seems to have been taken care of now.
What I do see here may be a coincidence of kernel upgrade and a faulty drive.
Some snippets of 2.2.19 log messages of a faulty drive below.

May  2 03:33:07 pollux kernel: (scsi1:0:1:0) Parity error during Data-In phase.
May  2 03:33:37 pollux kernel: scsi : aborting command due to timeout : pid
1188263, scsi1, channel 0, id 1, lun 0 Read (10) 00 01 04 cd 97 00 00 80 00 
May  2 03:33:38 pollux kernel: scsi : aborting command due to timeout : pid
1188268, scsi1, channel 0, id 0, lun 0 Read (10) 00 01 04 ce 2f 00 00 80 00 
May  2 03:33:38 pollux kernel: scsi : aborting command due to timeout : pid
1188269, scsi1, channel 0, id 0, lun 0 Read (10) 00 01 04 ce af 00 00 28 00 
May  2 03:33:38 pollux kernel: scsi : aborting command due to timeout : pid
1188270, scsi1, channel 0, id 1, lun 0 Read (10) 00 01 04 ce 17 00 00 80 00 
May  2 03:33:38 pollux kernel: scsi : aborting command due to timeout : pid
1188271, scsi1, channel 0, id 1, lun 0 Read (10) 00 01 04 ce 97 00 00 40 00 
May  2 03:33:38 pollux kernel: scsi : aborting command due to timeout : pid
1188272, scsi1, channel 0, id 2, lun 0 Read (10) 00 01 04 ce 17 00 00 80 00 
May  2 03:33:38 pollux kernel: scsi : aborting command due to timeout : pid
1188273, scsi1, channel 0, id 2, lun 0 Read (10) 00 01 04 ce 97 00 00 40 00 
May  2 03:33:38 pollux kernel: scsi : aborting command due to timeout : pid
1188274, scsi1, channel 0, id 3, lun 0 Read (10) 00 01 04 ce 17 00 00 80 00 
May  2 03:33:38 pollux kernel: scsi : aborting command due to timeout : pid
1188275, scsi1, channel 0, id 3, lun 0 Read (10) 00 01 04 ce 97 00 00 08 00 
May  2 03:33:39 pollux kernel: SCSI host 1 abort (pid 1188263) timed out -
resetting
May  2 03:33:39 pollux kernel: SCSI bus is being reset for host 1 channel 0
May  2 03:33:41 pollux kernel: SCSI host 1 reset (pid 1188263) timed out again -
May  2 03:33:41 pollux kernel: probably an unrecoverable SCSI bus or device
hang.

On 14-Sep-2001 Frank Schneider wrote:
> Holger Kiehl schrieb:
>> 
>> Hello
>> 
>> I am getting SCSI errors with an onboard Adaptec AIC-7890/1 Ultra2, but
>> only under very heavy disk load and only under kernel 2.2.19. These errors
>> do not appear under 2.2.18.
>> 
>> The system I have is a dual PIII-450 with 6 disks attached to the
>> controller.
>> All disks are put together in SW-Raid5 array with one configured as hot
>> spare.
>> 
> 
> (..log snipped..)
>  
>> >From Alan's changelog I see that there where changes in the AIC7xxx code.
>> Any idea what is wrong here?
> 
> Hello...
> 
> I (and someone else) had also mysterious problems with AIC7xxx and
> RAID1/5, but we use Kernel 2.4.x.
> 
> In Kernel 2.4.x you can choose between two versions of the
> aix7xxx-driver, one "old" one (Version 5.2.x) and a "new" one (Version
> 6.x.x). Do a "cat /proc/scsi/aic7xxx/0" to find your version.
> 
> We both found out that our problems dissapear when we use the "old"
> driver (my tests are still in progress because my error (always the same
> scsi-disk falling out of an raid5-array with an "internal error", but
> the disk seems to be good) only appeared randomly about once a week, so
> i still have to wait if it is really gone.
> 
> So perhaps you can try to use the older driver or determine the version
> of your aic7xxx-driver. Perhaps you can use the aic7xxx-driver from
> kernel 2.2.18 in Kernel 2.2.19 ?
> 
> You should also boot your system with the parameter "aic7xxx=verbose",
> that will provide more infos in the syslog.
> 
> Solong..
> Frank.
> 
> --
> Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
> Microsoft isn't the answer.
> Microsoft is the question, and the answer is NO.
> ... -.-
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
