Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbULXBIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbULXBIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 20:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbULXBIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 20:08:30 -0500
Received: from gw.c9x.org ([213.41.131.17]:11069 "HELO
	nerim.mx.42-networks.com") by vger.kernel.org with SMTP
	id S261354AbULXBI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 20:08:26 -0500
Date: Fri, 24 Dec 2004 02:08:03 +0100
From: "Frank Denis \(Jedi/Sector One\)" <lkml@pureftpd.org>
To: Bruce Allan <bwa@us.ibm.com>
Cc: matthew@wil.cx, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] [resend] VFS locking errors on max offset edge cases
Message-ID: <20041224010825.GA28608@c9x.org>
References: <1103842880.4702.87.camel@w-bwa3.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103842880.4702.87.camel@w-bwa3.beaverton.ibm.com>
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 03:01:20PM -0800, Bruce Allan wrote:
> Patch created against 2.6.10-rc3, tested on ppc64 with both
> _FILE_OFFSET_BITS set to 32 and 64.
> diff -Nurp -X dontdiff linux-2.6.10-rc3-vanilla/fs/compat.c linux-2.6.10-rc3/fs/compat.c
> +		if ((cmd == F_GETLK) &&
> +		    ((f.l_start > COMPAT_OFF_T_MAX) ||
> +		     ((f.l_start + f.l_len - 1) > COMPAT_OFF_T_MAX))) {
> +				ret = -EOVERFLOW;
> +				break;
> +			}
> +		}

  One extra },

> +		if ((cmd == F_GETLK64) &&
> +		    ((f.l_start > COMPAT_LOFF_T_MAX) ||
> +		     ((f.l_start + f.l_len - 1) > COMPAT_LOFF_T_MAX))) {
> +				ret = -EOVERFLOW;
> +				break;
> +			}
> +		}

  Another extra }.
  
  How could have this patch been tested?
  
  
