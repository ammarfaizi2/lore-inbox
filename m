Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291479AbSBABD1>; Thu, 31 Jan 2002 20:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291478AbSBABDU>; Thu, 31 Jan 2002 20:03:20 -0500
Received: from rj.sgi.com ([204.94.215.100]:17026 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S291477AbSBABDB>;
	Thu, 31 Jan 2002 20:03:01 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Revealing unload_lock to everyone 
In-Reply-To: Your message of "Thu, 31 Jan 2002 15:58:17 -0800."
             <3C59DA19.5060403@us.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 12:02:52 +1100
Message-ID: <23095.1012525372@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 15:58:17 -0800, 
Dave Hansen <haveblue@us.ibm.com> wrote:
>This came up in a conversation about ieee1394_core.c.  In 2.5.3, the BKL 
>is used to protect a module from being unloaded.  The code looks like this:
>
>         lock_kernel();
>         read_lock(&ieee1394_chardevs_lock);
>         file_ops = ieee1394_chardevs[blocknum].file_ops;
>         module = ieee1394_chardevs[blocknum].module;
>         read_unlock(&ieee1394_chardevs_lock);
>	...
>         INCREF(module);
>         unlock_kernel();
>	
>
>The question is, how can we keep the module from being unloaded between 
>the file_ops assignment, and the INCREF.  Do we have a general purpose 
>way, other than the BKL, to keep a module from being unloaded?  There is 
>unload_lock, but it is static to module.c.  We can always make it 
>global, but is there a better solution?

try_inc_mod_count().

