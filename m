Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWCHDsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWCHDsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbWCHDsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:48:19 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:50568 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750732AbWCHDsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:48:19 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Fw: Re: oops in choose_configuration()
Date: Tue, 7 Mar 2006 22:48:15 -0500
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200603072230_MC3-1-BA18-21AC@compuserve.com>
In-Reply-To: <200603072230_MC3-1-BA18-21AC@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603072248.16128.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 22:29, Chuck Ebbert wrote:
> In-Reply-To: <20060308005455.GA23921@kroah.com>
> 
> On Tue, 7 Mar 2006 16:54:55 -0800, Greg KH wrote:
> 
> > On Tue, Mar 07, 2006 at 04:54:24PM -0500, Chuck Ebbert wrote:
> > > At least one susbsystem rolls its own method of adding env vars to the
> > > uevent buffer, and it's so broken it triggers the WARN_ON() in
> > > lib/vsprintf.c::vsnprintf() by passing a negative length to that function.
> > > Start at drivers/input/input.c::input_dev_uevent() and watch the fun.
> > 
> > All of the INPUT_ADD_HOTPLUG_VAR() calls do use add_uevent_var(), so we
> > should be safe there.  The other calls also look safe, if not a bit
> > wierd...  So I don't see how we could change this to be any safer, do
> > you?
> 
> input.c line 747+ was recently added and caused the error message:
> 
> [1]=>   envp[i++] = buffer + len;
> [2]=>   len += snprintf(buffer + len, buffer_size - len, "MODALIAS=");
> [2]=>   len += print_modalias(buffer + len, buffer_size - len, dev) + 1;
> 
> [1]=>   envp[i] = NULL;
>         return 0;
> 
> [1] What is checking for enough space here?  This didn't overflow AFAICT
> but it could.
> 
> [2] The snprintf() and print_modalias() calls don't check for errors and
> thus don't return -ENOMEM when the buffer does fill up.  Shouldn't they
> do that instead of returning a truncated env string?  Only the final
> sanity test in snprintf() keeps them from overrunning the buffer.
> (It was print_modalias_bits() that actually caused the overflow.)
> 

I agree with all of the above, it will be fixed.

-- 
Dmitry
