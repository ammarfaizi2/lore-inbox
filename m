Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWDLQP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWDLQP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 12:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWDLQP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 12:15:27 -0400
Received: from xenotime.net ([66.160.160.81]:50850 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932077AbWDLQP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 12:15:26 -0400
Date: Wed, 12 Apr 2006 09:17:51 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       sam@ravnborg.org
Subject: Re: [RFC/POC] multiple CONFIG y/m/n
Message-Id: <20060412091751.feba2dd4.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0604121253540.32445@scrub.home>
References: <20060406224134.0430e827.rdunlap@xenotime.net>
	<87odzdh1fp.fsf@duaron.myhome.or.jp>
	<20060409220426.8027953a.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0604121253540.32445@scrub.home>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2006 13:00:22 +0200 (CEST) Roman Zippel wrote:

> Hi,
> 
> On Sun, 9 Apr 2006, Randy.Dunlap wrote:
> 
> > +void usage(char *progname)
> > +{
> > +	printf("%s [-o|-s|-d|-D|-n|-m|-y|-r] Kconfig_filename\n", progname);
> 
> |-D <config>|
> 
> > +	printf("  -o: oldconfig: ask only about new config symbols\n");
> > +	printf("  -s: silentoldconfig: don't ask about any symbol values\n");
> 
> It does ask about them, but suppresses a lot of prints.
> 
> > +	printf("  -d: defconfig: use default symbol values\n");
> 
> To be precise it uses arch/$ARCH/defconfig as default values.
> 
> > +	printf("  -n: set unknown symbol values to 'n'\n");
> > +	printf("  -m: set unknown symbol values to 'm'\n");
> > +	printf("  -y: set unknown symbol values to 'y'\n");
> 
> It actually tries to set all values to n/m/y.
> 
> > @@ -546,8 +564,8 @@ int main(int ac, char **av)
> >  			break;
> >  		case 'h':
> >  		case '?':
> > -			printf("%s [-o|-s] config\n", av[0]);
> > -			exit(0);
> > +			usage(av[0]);
> > +			break;
> 
> That's indeed a little obsolete. :-)

IMO the main points/questions are:

- where to document the command-line options and environment variables
  (including the recent KCONFIG_CONFIG):  in a usage() function or in
  Documentation/kbuild/usage.txt file?

- if the answer above is in a usage() function, how does a user invoke
  that help request?  Doing "make config -h" doesn't work: 'make' sees
  the -h and spits out its own help text.  Would a special case of
  'make config help' be acceptable or is this a good reason to use
  a usage.txt file instead?

- or have you already taken care of all of this?  8;)


Thanks.
---
~Randy
