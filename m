Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292491AbSBZU1Z>; Tue, 26 Feb 2002 15:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292798AbSBZU1Q>; Tue, 26 Feb 2002 15:27:16 -0500
Received: from daytona.gci.com ([205.140.80.57]:6922 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S292491AbSBZU1L> convert rfc822-to-8bit;
	Tue, 26 Feb 2002 15:27:11 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA315077C41F1@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Dylan Egan <crack_me@bigpond.com.au>, linux-kernel@vger.kernel.org
Subject: RE: Not Included Into Kernel?
Date: Tue, 26 Feb 2002 11:26:54 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dylan --

I'm working with Matt (who is the USB storage maintainer)
to get this into the mainline kernel.

Thanks

> -----Original Message-----
> From: Dylan Egan [mailto:crack_me@bigpond.com.au]
> Sent: Tuesday, February 26, 2002 11:04 AM
> To: linux-kernel@vger.kernel.org
> Subject: Not Included Into Kernel?
> 
> 
> This following patch from Leif Sawyer is not in 2.4.18 and is 
> indeed needed
> 
> diff -u --recursive linux-2.4.18-pre3/drivers/usb/storage/transport.c
> linux/drivers/usb/storage/transport.c
> --- linux-2.4.18-pre3/drivers/usb/storage/transport.cThu Jan 
> 10 13:08:18
> 2002
> +++ linux/drivers/usb/storage/transport.cThu Jan 10 13:13:36 2002
> @@ -1157,7 +1157,7 @@
>     	le32_to_cpu(bcs.Signature), bcs.Tag,
>     	bcs.Residue, bcs.Status);
>   	if (bcs.Signature != cpu_to_le32(US_BULK_CS_SIGN) ||
> -    	bcs.Tag != bcb.Tag ||
> +    	((bcs.Tag != bcb.Tag ) && (!(us->flags & US_FL_SL_IDE_BUG))) ||
>      	 bcs.Status > US_BULK_STAT_PHASE || partial != 13) {
>   	US_DEBUGP("Bulk logical error\n");
>   	return USB_STOR_TRANSPORT_ERROR;
> diff -u --recursive 
> linux-2.4.18-pre3/drivers/usb/storage/unusual_devs.h
> linux/drivers/usb/storage/unusual_devs.h
> --- linux-2.4.18-pre3/drivers/usb/storage/unusual_devs.hThu Jan 10
> 13:08:18 2002
> +++ linux/drivers/usb/storage/unusual_devs.hThu Jan 10 13:13:36 2002
> @@ -110,6 +110,28 @@
>                  "LS-120 Camera",
>                  US_SC_UFI, US_PR_CBI, NULL, 0),
> 
> +/* Reported by Peter Wächtler <pwaechtler@loewe-komp.de> */
> +UNUSUAL_DEV(  0x04ce, 0x0002, 0x0074, 0x0074,
> +"ScanLogic",
> +"SL11R-IDE 0049SQFP-1.2 A002",
> +US_SC_SCSI, US_PR_BULK, NULL,
> +US_FL_FIX_INQUIRY ),
> +
> +/* Reported by Leif Sawyer <leif@gci.net> */
> +UNUSUAL_DEV(  0x04ce, 0x0002, 0x0240, 0x0240,
> +"H45 ScanLogic",
> +"SL11R-IDE 9951SQFP-1.2 K004",
> +US_SC_SCSI, US_PR_BULK, NULL,
> +US_FL_FIX_INQUIRY | US_FL_SL_IDE_BUG ),
> +
> +/* Reported by Rene Engelhard <mail@rene-engelhard.de> and
> +    Dylan Egan <crack_me@bigpond.com.au> */
> +UNUSUAL_DEV(  0x04ce, 0x0002, 0x0260, 0x0260,
> +"ScanLogic",
> +"SL11R-IDE unknown HW rev",
> +US_SC_SCSI, US_PR_BULK, NULL,
> +US_FL_SL_IDE_BUG ),
> +
>   /* Most of the following entries were developed with the help of
>    * Shuttle/SCM directly.
>    */
> diff -u --recursive linux-2.4.18-pre3/drivers/usb/storage/usb.h
> linux/drivers/usb/storage/usb.h
> --- linux-2.4.18-pre3/drivers/usb/storage/usb.hThu Nov 22 
> 10:49:34 2001
> +++ linux/drivers/usb/storage/usb.hThu Jan 10 13:13:36 2002
> @@ -101,6 +101,7 @@
>   #define US_FL_IGNORE_SER      0x00000010 /* Ignore the 
> serial number given
> */
>   #define US_FL_SCM_MULT_TARG   0x00000020 /* supports 
> multiple targets */
>   #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY 
> response needs fixing
> */
> +#define US_FL_SL_IDE_BUG      0x00000100 /* ScanLogic 
> usb-ide workaround */
> 
>   #define USB_STOR_STRING_LEN 32
> 
> Regards,
> 
> Dylan.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
