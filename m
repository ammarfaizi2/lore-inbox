Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbTDPUQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 16:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbTDPUQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 16:16:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2321 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264578AbTDPUQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 16:16:04 -0400
Message-ID: <3E9DBCA7.2070608@zytor.com>
Date: Wed, 16 Apr 2003 13:27:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdevt-diff
References: <UTC200304142201.h3EM19S07185.aeb@smtp.cwi.nl> <20030414221110.GK4917@ca-server1.us.oracle.com> <200304142218.h3EMIKIO017775@turing-police.cc.vt.edu> <b7k1gg$6uc$1@cesium.transmeta.com> <20030416201948.GA18717@win.tue.nl>
In-Reply-To: <20030416201948.GA18717@win.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Wed, Apr 16, 2003 at 09:48:16AM -0700, H. Peter Anvin wrote:
> 
> 
>>Not really, but it's certainly a nice capability.  However, iso9660
>>(RockRidge, actually) has 64 bits of dev_t space; it's actually split
>>into two 32-bit entries specified as "high 32 bits" and "low 32 bits."
>>
>>I'm not positive if Linux expects those to contain major:minor or
>>0:<16-bit-dev_t>.
> 
>       case SIG('P','N'):
>         { int high, low;
>           high = isonum_733(rr->u.PN.dev_high);
>           low = isonum_733(rr->u.PN.dev_low);
>           /*
>            * The Rock Ridge standard specifies that if sizeof(dev_t) <= 4,
>            * then the high field is unused, and the device number is completely
>            * stored in the low field.  Some writers may ignore this subtlety,
>            * and as a result we test to see if the entire device number is
>            * stored in the low field, and use that.
>            */
>           if((low & ~0xff) && high == 0) {
>             inode->i_rdev = mk_kdev(low >> 8, low & 0xff);
>           } else {
>             inode->i_rdev = mk_kdev(high, low);
>           }
>         }
>         break;
> 
> (Here isonum_733 gets 32 bits.)

OK, in other words, it accepts either format, either:

0x000000000000MMmm or 0x000000MM000000mm

This is perfectly consistent with what dev_t does for a 32:32 split; the
previous form would be the "backwards compatibility" format and the
second the "new" format.

	-hpa

