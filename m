Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbQKBOvl>; Thu, 2 Nov 2000 09:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132177AbQKBOvb>; Thu, 2 Nov 2000 09:51:31 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:777 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S132147AbQKBOv1>;
	Thu, 2 Nov 2000 09:51:27 -0500
Message-ID: <3A017F33.BE30ACD@mandrakesoft.com>
Date: Thu, 02 Nov 2000 09:50:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Sailer <sailer@ife.ee.ethz.ch>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Poll and OSS API
In-Reply-To: <3A017443.8E436A97@ife.ee.ethz.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Sailer wrote:
> 
> The OSS API (http://www.opensound.com/pguide/oss.pdf, page 102ff)
> specifies that a select _with the sounddriver's filedescriptor
> set in the read mask_ should start the recording.
> 
> Implementing this is currently not possible, as the driver does
> not get to know whether the application had the filedescriptor
> set in the select call. Similarily for poll, the driver does not
> get the caller's events.

Well, it's only a problem for full duplex :)  If you are write-only in
poll(), read doesn't apply.  Read-only in poll(), and you start DMA. 
For full duplex...  my Via driver starts DMA'ing.  That was my
interpretation of the spec.


> I don't think this is all that important though, because
> it's that way for more than a year and the first complaint
> reached me yesterday.

What was the complaint?

FWIW I highly recommend Rui Sousa's oss-test stuff.  Check out the
"emu10k1" module from Creative's CVS server, and look in the
emu10k1/utils/oss-test directory.

Regards,

	Jeff


Creative CVS info:
export
CVSROOT=:pserver:cvsguest@opensource.creative.com:/usr/local/cvsroot
echo note - password is 'cvsguest'

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
