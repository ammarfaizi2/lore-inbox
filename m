Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268745AbUI2RlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268745AbUI2RlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268735AbUI2RlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:41:25 -0400
Received: from open.hands.com ([195.224.53.39]:41350 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268756AbUI2RlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:41:09 -0400
Date: Wed, 29 Sep 2004 18:52:04 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to allow sys_pread64 and sys_pwrite64 to be used from modules
Message-ID: <20040929175204.GA6488@lkcl.net>
References: <20040929125835.GA6764@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929125835.GA6764@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scratch that: i found that vfs_read along with filp_open and filp_close
would do the job.

having a ball :)

On Wed, Sep 29, 2004 at 01:58:35PM +0100, Luke Kenneth Casson Leighton wrote:
> i do not know if this does any damage (and i'm going to find out!)
> 
> i seek to use these two functions from an experimental kernel module: i
> get warnings about "symbol not found" without this patch:
> 
> 
> Index: fs/read_write.c
> ===================================================================
> RCS file: /cvsroot/selinux/nsa/linux-2.6/fs/read_write.c,v
> retrieving revision 1.1.1.6
> diff -u -3 -p -u -r1.1.1.6 read_write.c
> --- fs/read_write.c	18 Jun 2004 19:30:06 -0000	1.1.1.6
> +++ fs/read_write.c	29 Sep 2004 12:45:31 -0000
> @@ -318,6 +318,7 @@ asmlinkage ssize_t sys_pread64(unsigned 
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(sys_pread64);
>  
>  asmlinkage ssize_t sys_pwrite64(unsigned int fd, const char __user *buf,
>  			      size_t count, loff_t pos)
> @@ -337,6 +338,7 @@ asmlinkage ssize_t sys_pwrite64(unsigned
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(sys_pwrite64);
>  
>  /*
>   * Reduce an iovec's length in-place.  Return the resulting number of segments
> 
> 
> -- 
> --
> Truth, honesty and respect are rare commodities that all spring from
> the same well: Love.  If you love yourself and everyone and everything
> around you, funnily and coincidentally enough, life gets a lot better.
> --
> <a href="http://lkcl.net">      lkcl.net      </a> <br />
> <a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />
> 

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

