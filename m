Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSJROcD>; Fri, 18 Oct 2002 10:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265101AbSJROcD>; Fri, 18 Oct 2002 10:32:03 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:34832 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265099AbSJROcC>;
	Fri, 18 Oct 2002 10:32:02 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@sgi.com>
Cc: John Hesterberg <jh@sgi.com>, linux-kernel@vger.kernel.org,
       Robin Holt <holt@sgi.com>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG 
In-reply-to: Your message of "Thu, 17 Oct 2002 22:44:10 -0400."
             <20021017224410.A25801@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Oct 2002 00:37:50 +1000
Message-ID: <29226.1034951870@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002 22:44:10 -0400, 
Christoph Hellwig <hch@sgi.com> wrote:
>On Thu, Oct 17, 2002 at 10:21:47AM -0500, John Hesterberg wrote:
>> 2.5.43 versions of CSA, Job, and PAGG patches are available at:
>>     ftp://oss.sgi.com/projects/pagg/download/linux-2.5.43-pagg-job.patch
>>     ftp://oss.sgi.com/projects/csa/download/linux-2.5.43-csa.patch
>
>+#if defined (CONFIG_CSA_JOB_ACCT) || defined (CONFIG_CSA_JOB_ACCT_MODULE)
>
>Umm, stubbing stuff out based on _MODULE is a bad, bad idea.  Just make it
>a bool instead.

The construct #if defined(CONFIG_FOO) || defined(CONFIG_FOO_MODULE) is
required for all CONFIG_FOO which can be defined as tristate.

   .config             Source code
  CONFIG_FOO    CONFIG_FOO  CONFIG_FOO_MODULE
      n              undef      undef
      y                1        undef
      m              undef        1

If CSA_JOB_ACCT can be a module or builtin then the code is correct.
OTOH, if CSA_JOB_ACCT is a boolean subset of CSA then it should be a
bool, not a tristate.  Given

if [ "$CONFIG_PAGG" = "y" ]; then
   tristate '  Process aggregate based jobs' CONFIG_PAGG_JOB
   dep_tristate '    CSA Job Accounting' CONFIG_CSA_JOB_ACCT $CONFIG_PAGG_JOB
fi

and assuming that CONFIG_PAGG_JOB=y, CONFIG_CSA_JOB_ACCT=m is a valid
combination, then the code is correct.

