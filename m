Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288850AbSBDKUp>; Mon, 4 Feb 2002 05:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288851AbSBDKUg>; Mon, 4 Feb 2002 05:20:36 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:16133 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S288850AbSBDKUb>;
	Mon, 4 Feb 2002 05:20:31 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Vlodavsky, Zvi" <zvi.vlodavsky@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Using "query_module" 
In-Reply-To: Your message of "Mon, 04 Feb 2002 12:04:19 +0200."
             <436282DBEE7CD51191E30002A50A636924113B@hasmsx102.iil.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Feb 2002 21:20:09 +1100
Message-ID: <19550.1012818009@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2002 12:04:19 +0200 , 
"Vlodavsky, Zvi" <zvi.vlodavsky@intel.com> wrote:
>Please personally CC me with responses on this posting:
>I would like to use the "query_module" system call with the QM_SYMBOLS flag
>in an application, but I am not sure of what the appropriate way of doing it
>is, and whether it is safe.

query_module(NULL, 0, NULL, 0, NULL) returns 0 if the kernel supports
query_module, -ENOSYS if it does not.

If the kernel supports query_module,
  query_module(NULL, -1, NULL, 0, NULL)
returns -ENOSYS if the kernel has been compiled without modules,
-EINVAL if the kernel was compiled with module support.

Grab the modutils source and see utils/modstat.c::new_get_kernel_info,
it uses all the query_module facilities.

