Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131734AbRBEU14>; Mon, 5 Feb 2001 15:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131640AbRBEU1i>; Mon, 5 Feb 2001 15:27:38 -0500
Received: from cnxtsmtp2.conexant.com ([198.62.9.253]:34529 "EHLO
	cnxtsmtp2.conexant.com") by vger.kernel.org with ESMTP
	id <S131650AbRBEU1c>; Mon, 5 Feb 2001 15:27:32 -0500
From: rui.sousa@conexant.com
Subject: Re: 2.4.{1,2pre1} oops in via82cxxx_audio (?)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, Matthew Harrell <mharrell@bittwiddlers.com>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF9056ECFB.0D139AF2-ONC12569EA.006E4DDA@conexant.com>
Date: Mon, 5 Feb 2001 21:27:20 +0100
X-MIMETrack: Serialize by Router on NPBSMTP1/Server/Conexant(Release 5.0.5 |September 22, 2000) at
 02/05/2001 12:27:21 PM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=882569EA00705DAE8f9e8a93df938690918c882569EA00705DAE"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=882569EA00705DAE8f9e8a93df938690918c882569EA00705DAE
Content-type: text/plain; charset=us-ascii





On 05/02/01 20:55 Jeff Garzik wrote:

> rui.sousa@conexant.com wrote:
> >
> > On Mon, 5 Feb 2001, Matthew Harrell wrote:
> >
> > > : Ouch.  After applying the attached patch, do any of the assertions
> > > : trigger?  (You should get a message 'Assertion failed! ...' right
before
> > > : the oops)
> > >
> > > : +   assert (chan->sgtable != NULL);
> > >
> > > Yep, I get this one "chan->sgtable != NULL".  I have no idea what
this means
> > > but I got it one out of the two times I tried.
> > >
> >
> > Is there any other device on the same irq?
>
> Yes, it looks like:
>
>   Matthew Harrell wrote:
>   >   PCI: Found IRQ 10 for device 00:14.5
>   >   PCI: The same IRQ used for device 00:04.0
>
> The attached patch, sent to Matthew privately, apparently has fixed his
> problem.  Right now it looks like an out-of-band interrupt...   The
> interrupt is enabled via request_irq, and its shared so the interrupt
> handler will be called.  However the channel isn't active so the SG
> table hasn't been allocated yet.

But your interrupt status register should indicate that it wasn't the
sound device that generated the interrupt...


Matthew, can you try the attached patched and report the output?
You should apply it on a clean 2.4.1 (without the patches Jeff sent you).
Try only sound playback.

Rui Sousa


(See attached file: patch)

--0__=882569EA00705DAE8f9e8a93df938690918c882569EA00705DAE
Content-type: application/octet-stream; 
	name="patch"
Content-Disposition: attachment; filename="patch"
Content-transfer-encoding: base64

LS0tIHZpYTgyY3h4eF9hdWRpby5jLm9yaWcJTW9uIEZlYiAgNSAyMToxNzoxOSAyMDAxCisrKyB2
aWE4MmN4eHhfYXVkaW8uYwlNb24gRmViICA1IDIxOjIzOjEzIDIwMDEKQEAgLTE1OTgsNiArMTU5
OCw3IEBACiB7CiAJc3RydWN0IHZpYV9pbmZvICpjYXJkID0gZGV2X2lkOwogCXUzMiBzdGF0dXMz
MjsKKwl1OCBzdGF0dXM7CiAKIAkvKiB0byBtaW5pbWl6ZSBpbnRlcnJ1cHQgc2hhcmluZyBjb3N0
cywgd2UgdXNlIHRoZSBTR0Qgc3RhdHVzCiAJICogc2hhZG93IHJlZ2lzdGVyIHRvIGNoZWNrIHRo
ZSBzdGF0dXMgb2YgYWxsIGlucHV0cyBhbmQKQEAgLTE2MDksNiArMTYxMCwxMiBAQAogCQlyZXR1
cm47CiAKIAlEUFJJTlRLICgiaW50ciwgc3RhdHVzMzIgPT0gMHglMDhYXG4iLCBzdGF0dXMzMik7
CisKKwlpZiAoY2FyZC0+Y2hfb3V0LnNndGFibGUgPT0gTlVMTCkgeworCSAgICAgICAgc3RhdHVz
ID0gaW5iIChjYXJkLT5iYXNlYWRkciArIFZJQV9CQVNFMF9QQ01fT1VUX0NIQU4pICYgKFZJQV9T
R0RfRkxBRyB8IFZJQV9TR0RfRU9MIHwgVklBX1NHRF9TVE9QUEVEKTsKKwkJcHJpbnRrKCIleCAl
eFxuIiwgc3RhdHVzMzIsIHN0YXR1cyk7CisJCXJldHVybjsKKwl9CiAKIAkvKiBzeW5jaHJvbml6
ZSBpbnRlcnJ1cHQgaGFuZGxpbmcgdW5kZXIgU01QLiAgdGhpcyBzcGlubG9jawogCSAqIGdvZXMg
YXdheSBjb21wbGV0ZWx5IG9uIFVQCg==

--0__=882569EA00705DAE8f9e8a93df938690918c882569EA00705DAE--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
