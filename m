Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280510AbRK1T47>; Wed, 28 Nov 2001 14:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280554AbRK1T4m>; Wed, 28 Nov 2001 14:56:42 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:55973 "EHLO
	shookay.e-steel.com") by vger.kernel.org with ESMTP
	id <S280510AbRK1T4V>; Wed, 28 Nov 2001 14:56:21 -0500
To: haferfrost@web.de ("Matthias Benkmann")
Cc: linux-kernel@vger.kernel.org
Subject: Re: sym53c875: reading /proc causes SCSI parity error
In-Reply-To: <3C053AF2.10037.4CCE47@localhost> <3C054BA2.9822.8DFF90@localhost>
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 28 Nov 2001 14:56:13 -0500
In-Reply-To: <3C054BA2.9822.8DFF90@localhost>
Message-ID: <xlt8zcqsm8y.fsf@shookay.e-steel.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok I found the mail in some archives: it does not happen with
/proc/scsi/sym... but with /proc/bus/pci/xx (it seems that it messes the
scsi chip).

Here the answer (note that as a regular user you can't read more than the
first 128 bytes):
http://groups.google.com/groups?hl=en&threadm=fa.fhj0sbv.1ans7qt%40ifi.uio.no&rnum=1&prev=/groups%3Fq%3Dsym53c8xx%2Bproc%2Bscsi%2Breset%2Blinux%2Bmathieu%26hl%3Den%26rnum%3D1%26selm%3Dfa.fhj0sbv.1ans7qt%2540ifi.uio.no

> Oh, I've forgotten another thing. If I do cat /proc/bus/pci/00/* when I'm
> root (and only root), I get scsi reset (especially when I'm copying big
> files). Is this a bug or a feature?

Both. :-)
You donnot want to read configuration space beyong byte 128 for chip
earlier than SYM53C896.

Regards,
   Gérard.


haferfrost@web.de ("Matthias Benkmann") writes:
> On 28 Nov 2001, at 14:13, Mathieu Chouquet-Stringer wrote:
> 
> > I bet it only happens when you're root and you read =
> /proc/scsi/sym53c8xx/0
> > (or whatever in your case).
> >=20
> > I had this discussion with G=E9rard Roudier and it's not a bug, =
> rather a
> > feature...
> 
> Care to elaborate? What happens when you read that file? And why does =
> it=20
> cause an error even when the disk is not currently being accessed? As I =
> 
> said there can be considerable time between running my script and=20
> accessing the disk. And why do I get different errors depending on =
> whether=20
> I access the disk before I run the script or run the script before I=20
> access the disk?
> 
> MSB
> 
> ----
> Who is this General Failure,
> and why is he reading my disk ?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
