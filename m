Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319428AbSILEJZ>; Thu, 12 Sep 2002 00:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319429AbSILEJZ>; Thu, 12 Sep 2002 00:09:25 -0400
Received: from smtp4.us.dell.com ([143.166.148.135]:5577 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP
	id <S319428AbSILEJY>; Thu, 12 Sep 2002 00:09:24 -0400
Date: Wed, 11 Sep 2002 23:13:17 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: jw schultz <jw@pegasys.ws>
cc: linux-kernel@vger.kernel.org
Subject: Re: the userspace side of driverfs
In-Reply-To: <20020912012552.GF10315@pegasys.ws>
Message-ID: <Pine.LNX.4.44.0209112254260.17242-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The main ideal that we're shooting for is to have one ASCII value per
> file. The ASCII part is mandatory, but there will definitely be exceptions
> where we will have an array of or multiple values per file. We want to
> minimize those instances, though. Both for the sake of easy parsing, but
> also for easy formatting within the drivers.

On IA-64, I've got the arch/ia64/kernel/efivars.c module that exports
/proc/efi/vars/{NVRAM-variables}.  It violates several rules of /proc
which I'd like to address in 2.5.x via driverfs.
1) It's in /proc but isn't process-related.
2) It exports its data as binary, not ascii.

Proc was chosen because it was simple, didn't require a major/minor
number, showed easily the set of NVRAM variables that were available
without needing a separate program to go and query a /dev/efivars file
to list them; cat and tar are sufficient for making copies of
variables and restoring them back again.  These exact features make
driverfs make sense too.

1) is easy to fix.  2) a little less so.  The data structure being
exported is a little over 2KB in length; The data is binary (itself a
variable length set of structures each with no ascii representation).
An ascii representation in "%02x" format will be longer than a 4K page
given to fill out and return.  Undoubtedly there's a better way to
handle this, and I'm open to suggestions.  The thing being exported is
efi_variable_t.

For such cases where the data being exported is really binary,
having a common set of parse/unparse routines would be nice. 

-Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1-2/2002! (IDC Aug 2002)

