Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUG0TdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUG0TdQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUG0TdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:33:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:40836 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266508AbUG0Tc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:32:59 -0400
Date: Tue, 27 Jul 2004 12:31:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josh Aas <josha@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add core dump file name pattern option for cpu id
Message-Id: <20040727123115.794577d7.akpm@osdl.org>
In-Reply-To: <1090955660.20503.13.camel@coetzee.americas.sgi.com>
References: <1090955660.20503.13.camel@coetzee.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Aas <josha@sgi.com> wrote:
>
>  ---------------------------------------------------------
>  --- a/fs/exec.c	2004-07-13 14:32:24.000000000 -0500
>  +++ b/fs/exec.c	2004-07-15 13:16:17.000000000 -0500
>  @@ -1276,6 +1276,14 @@ void format_corename(char *corename, con
>   					goto out;
>   				out_ptr += rc;
>   				break;
>  +			/* cpu id */
>  +			case 'c':
>  +				rc = snprintf(out_ptr, out_end - out_ptr,
>  +					      "%d", smp_processor_id());
>  +				if (rc > out_end - out_ptr)
>  +					goto out;
>  +				out_ptr += rc;
>  +				break;
>   			default:
>   				break;
>   			}
>  ---------------------------------------------------------
> 
>  Is there any reason this couldn't be taken into the kernel? I didn't get
>  any response at all and it seems to be a safe and useful patch. Any
>  feedback would be appreciated.

There's no guarantee at all that we're still running on the same CPU by the
time we get here.

Possibly do_coredump() could fish the relevant info out of the pt_regs in
some arch-dependent way, or it needs to be propagated down in some manner. 
Either way, the patch will become more complex.

Any future revision of this patch should include an update to
Documentation/sysctl/kernel.txt:core_pattern please.
