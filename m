Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbVI1HXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVI1HXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbVI1HXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:23:37 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:28811 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030207AbVI1HXg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:23:36 -0400
Subject: Re: AIO Support and related package information??
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: vikas gupta <vikas_gupta51013@yahoo.co.in>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <20050927070933.77908.qmail@web8409.mail.in.yahoo.com>
References: <20050927070933.77908.qmail@web8409.mail.in.yahoo.com>
Date: Wed, 28 Sep 2005 09:25:24 +0200
Message-Id: <1127892324.2103.39.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/09/2005 09:36:50,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/09/2005 09:36:56,
	Serialize complete at 28/09/2005 09:36:56
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 08:09 +0100, vikas gupta wrote:
> HI Sebastien,
> Thanks for your Reply 
> ...
> 
> As i told you that i am trying to build libposix
> package for arm platform,with bare Kernel AIO Support
> (without applying patches) and libposix-0.6 package.
> 
> When i tried to build the package then while
> configuration it is  showing Following
> 
> Error:
> 
> "Checking for default value for max events...
> configure: error: cannot 
> run
> test program while cross compiling
> See `config.log' for more details."
> 
> I traced the configure script for following Error and
> got following code that is, I think causing this
> Problem:
> 
> Code in configure script:
> 
> if test "${enable_default_maxevents+set}" = set; then
>   enableval="$enable_default_maxevents"
>   ac_aio_default_maxevents=$enableval
> else
>   echo "$as_me:$LINENO: checking for default value for
> max events" >&5
> echo $ECHO_N "checking for default value for max
> events... $ECHO_C" >&6
> if test "$cross_compiling" = yes; then
>   { { echo "$as_me:$LINENO: error: cannot run test
> program while cross
> compiling
> See \`config.log' for more details." >&5
> echo "$as_me: error: cannot run test program while
> cross compiling
> See \`config.log' for more details." >&2;}
>    { (exit 1); exit 1; }; }
> else
>   cat >conftest.$ac_ext <<_ACEOF
> 
> Even on x86 it is going into else part but their as
> cross compiling is false in that case it goes to 
> cat > conftest.$ac_ext <<_ACEOF
> 
> 
> So With this code while cross compiling we always face
> the same  problem...
> 
> So Can you please tell me how to resolve this
> problem...
> 
> Thanks in advance...
> 
> Vikas
> 

  Ok, then try to disable all the feature with:

./configure --disable-default-maxevents --disable-aio-signal
--disable-lio-signal --disable-lio-wait --disable-cancel-fd
--disable-buffered-aio

  that way, the configure script will not try to autodetect
kernel features.

  The configure options available may be found with

    configure --help

  aio_read and aio_write with no event notification should work
provided you implemented the ARM syscall wrappers.

  Sebastien.


-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

