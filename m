Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264572AbTDPUKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 16:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264576AbTDPUKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 16:10:35 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:54794 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264572AbTDPUKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 16:10:33 -0400
Date: Wed, 16 Apr 2003 22:19:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdevt-diff
Message-ID: <20030416201948.GA18717@win.tue.nl>
References: <UTC200304142201.h3EM19S07185.aeb@smtp.cwi.nl> <20030414221110.GK4917@ca-server1.us.oracle.com> <200304142218.h3EMIKIO017775@turing-police.cc.vt.edu> <b7k1gg$6uc$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7k1gg$6uc$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 09:48:16AM -0700, H. Peter Anvin wrote:

> Not really, but it's certainly a nice capability.  However, iso9660
> (RockRidge, actually) has 64 bits of dev_t space; it's actually split
> into two 32-bit entries specified as "high 32 bits" and "low 32 bits."
> 
> I'm not positive if Linux expects those to contain major:minor or
> 0:<16-bit-dev_t>.

      case SIG('P','N'):
        { int high, low;
          high = isonum_733(rr->u.PN.dev_high);
          low = isonum_733(rr->u.PN.dev_low);
          /*
           * The Rock Ridge standard specifies that if sizeof(dev_t) <= 4,
           * then the high field is unused, and the device number is completely
           * stored in the low field.  Some writers may ignore this subtlety,
           * and as a result we test to see if the entire device number is
           * stored in the low field, and use that.
           */
          if((low & ~0xff) && high == 0) {
            inode->i_rdev = mk_kdev(low >> 8, low & 0xff);
          } else {
            inode->i_rdev = mk_kdev(high, low);
          }
        }
        break;

(Here isonum_733 gets 32 bits.)

