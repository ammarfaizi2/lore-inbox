Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSJPXlG>; Wed, 16 Oct 2002 19:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbSJPXlG>; Wed, 16 Oct 2002 19:41:06 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:17932 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261486AbSJPXlF>;
	Wed, 16 Oct 2002 19:41:05 -0400
Date: Wed, 16 Oct 2002 16:46:53 -0700
From: Greg KH <greg@kroah.com>
To: joe perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] change format of LSM hooks
Message-ID: <20021016234653.GA27285@kroah.com>
References: <20021015194545.GC15864@kroah.com> <20021015.124502.130514745.davem@redhat.com> <20021015201209.GE15864@kroah.com> <20021015.131037.96602290.davem@redhat.com> <20021015202828.GG15864@kroah.com> <20021016000706.GI16966@kroah.com> <20021016081539.GF20421@kroah.com> <20021016185927.GA25475@kroah.com> <1034786033.9520.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034786033.9520.8.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 12:33:50PM -0400, joe perches wrote:
> On Wed, 2002-10-16 at 14:59, Greg KH wrote:
> 
> I think something like:
> 
> 	#define check_security(type,args...) security_##type(##args)
> 
> would be cleaner and would prefer not collapsing the
> 
> 	ret = check_security()
> 	if (ret)
> 
> function use

No, I have to collapse the if and assign lines in order to take
advantage of the compiler when CONFIG_SERIAL=n.  Then anything within
the if {} will just be compiled away if the return value of a static
inline function is 0.

As for using a macro, that doesn't really have any advantages over the
existing different functions.

thanks,

greg k-h
