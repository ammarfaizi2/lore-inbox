Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAGJGq>; Sun, 7 Jan 2001 04:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbRAGJG1>; Sun, 7 Jan 2001 04:06:27 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:14328 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S129562AbRAGJGR>;
	Sun, 7 Jan 2001 04:06:17 -0500
To: Matthias Juchem <juchem@uni-mannheim.de>
Cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] new bug report script
In-Reply-To: <Pine.LNX.4.30.0101070950530.7104-100000@gandalf.math.uni-mannheim.de>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From: Ulrich Drepper <drepper@redhat.com>
Date: 07 Jan 2001 01:06:15 -0800
In-Reply-To: Matthias Juchem's message of "Sun, 7 Jan 2001 10:00:02 +0100 (CET)"
Message-ID: <m3vgrrafzs.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Juchem <matthias@gandalf.math.uni-mannheim.de> writes:

>      # c library 5
> -    if ( -e "/lib/libc.so.5" ) {
> -	( $v_libc5 = `/lib/libc.so.5`) =~ m/GNU C Library .+ version (\S+),/;
> -	$v_libc5 = $1;
> -    } else {
> -	$v_libc5 = "not found";
> +    opendir LIBDIR, "/lib" or die "/lib/ not found, very strange";
> +    my @allfiles = readdir LIBDIR;
> +    closedir LIBDIR;
> +    $v_libc5 = 'not found';
> +    foreach (sort @allfiles) {
> +	m/libc.so.(5\S+)/ and $v_libc5 = $1;
>      }
> +    closedir LIBDIR;

This won't work everywhere either.  Red Hat systems (maybe others)
have libc5 out of the way in a separate subdir.  Your best bet is to
use ldconfig:

  /sbin/ldconfig -p|grep libc.so.5

which produces something like

          libc.so.5 (libc5) => /usr/i486-linux-libc5/lib/libc.so.5

and then look in that directory (/usr/i486-linux-libc5/lib).

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
