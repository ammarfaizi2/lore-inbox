Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbTCESQ6>; Wed, 5 Mar 2003 13:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267364AbTCESQ6>; Wed, 5 Mar 2003 13:16:58 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:42508 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267346AbTCESQ5>; Wed, 5 Mar 2003 13:16:57 -0500
Date: Wed, 5 Mar 2003 18:27:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Derek Atkins <derek@ihtfp.com>
Cc: Kostadin Karaivanov <larry@minfin.bg>, linux-kernel@vger.kernel.org
Subject: Re: ipsec-tools 0.1 + kernel 2.5.64
Message-ID: <20030305182715.A27888@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Derek Atkins <derek@ihtfp.com>,
	Kostadin Karaivanov <larry@minfin.bg>, linux-kernel@vger.kernel.org
References: <sjmof4pvfx7.fsf@kikki.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <sjmof4pvfx7.fsf@kikki.mit.edu>; from derek@ihtfp.com on Wed, Mar 05, 2003 at 01:15:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 01:15:00PM -0500, Derek Atkins wrote:
> Hmm...  What version of glibc are you using?  This seems to imply that
> getifaddrs() and freeifaddrs() is now in libc, where it wasn't before.
> I didn't know it got added -- I wonder when that happened?

It's new in glibc 2.3

>  
> @@ -78,7 +78,7 @@
>  static int suitable_ifaddr6 __P((const char *, const struct sockaddr *));
>  #endif
>  
> -#ifdef __linux__
> +#if defined(__linux__) && !defined(HAVE_GETIFADDRS)

#ifdef <OS> is a very bad style.  As you're already using autoconf
I'd suggest just checking for HAVE_GETIFADDRS

