Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319436AbSILFGp>; Thu, 12 Sep 2002 01:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319437AbSILFGp>; Thu, 12 Sep 2002 01:06:45 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:33804 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S319436AbSILFGn>; Thu, 12 Sep 2002 01:06:43 -0400
Date: Wed, 11 Sep 2002 22:11:27 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: the userspace side of driverfs
Message-ID: <20020912051127.GH10315@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20020912012552.GF10315@pegasys.ws> <Pine.LNX.4.44.0209112254260.17242-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209112254260.17242-100000@humbolt.us.dell.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 11:13:17PM -0500, Matt Domsch wrote:
> > The main ideal that we're shooting for is to have one ASCII value per
> > file. The ASCII part is mandatory, but there will definitely be exceptions
> > where we will have an array of or multiple values per file. We want to
> > minimize those instances, though. Both for the sake of easy parsing, but
> > also for easy formatting within the drivers.
> 
> On IA-64, I've got the arch/ia64/kernel/efivars.c module that exports
> /proc/efi/vars/{NVRAM-variables}.  It violates several rules of /proc
> which I'd like to address in 2.5.x via driverfs.
> 1) It's in /proc but isn't process-related.
> 2) It exports its data as binary, not ascii.
> 
> Proc was chosen because it was simple, didn't require a major/minor
> number, showed easily the set of NVRAM variables that were available
> without needing a separate program to go and query a /dev/efivars file
> to list them; cat and tar are sufficient for making copies of
> variables and restoring them back again.  These exact features make
> driverfs make sense too.
> 
> 1) is easy to fix.  2) a little less so.  The data structure being
> exported is a little over 2KB in length; The data is binary (itself a
> variable length set of structures each with no ascii representation).
> An ascii representation in "%02x" format will be longer than a 4K page
> given to fill out and return.  Undoubtedly there's a better way to
> handle this, and I'm open to suggestions.  The thing being exported is
> efi_variable_t.
> 
> For such cases where the data being exported is really binary,
> having a common set of parse/unparse routines would be nice. 

I don't know what others think of this but i'd say that some
binary files are appropriate.  In a case like this i'd say
a files named 'nvram' and 'bios' or 'firmware' would be good
candidates for opaque binary structures and firmware.  This
is particularly the true if the data is purely related to
the device.  Ultimately it'd be nice to be able to upload
and download (install)  firmware this way.

Now if a datum is a parameter suitable for tuning i'd like
it made visible and updatable in an ASCII form.  In other
words i'd like to see an end to the proliferation of obscure
tools like hdparm.

These opinion does not necessarily reflect the views of
anyone else.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
