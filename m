Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTICUKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTICUIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:08:34 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:37136 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264406AbTICUHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:07:40 -0400
Date: Wed, 3 Sep 2003 22:07:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: carbonated beverage <ramune@net-ronin.org>, mikal@stillhq.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: minor TMPDIR fix
Message-ID: <20030903200736.GA12723@mars.ravnborg.org>
Mail-Followup-To: carbonated beverage <ramune@net-ronin.org>,
	mikal@stillhq.com, linux-kernel@vger.kernel.org
References: <20030903192726.GA23442@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903192726.GA23442@net-ronin.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 12:27:26PM -0700, carbonated beverage wrote:
> Hi,
> 
> 	Just a small fix to make the makeman script use $TMPDIR from the
> environment if it's set.
Michael Still contributed this script - I have added him in to:

	Sam

> 	Sent it to the listed maintainer, mec, but he said he's not active
> in the kernel development anymore.  I'll send out a patch to update the
> MAINTAINERS file if anyone can tell me who it should be set to.
> 
> -- DN
> Daniel
> 
> --- 1.2/scripts/makeman	Thu Aug 14 18:17:42 2003
> +++ edited/scripts/makeman	Wed Sep  3 01:51:53 2003
> @@ -12,7 +12,7 @@
>  ##             $3 -- the filename which contained the sgmldoc output
>  ##                     (I need this so I know which manpages to convert)
>  
> -my($LISTING, $GENERATED, $INPUT, $OUTPUT, $front, $mode, $filename);
> +my($LISTING, $GENERATED, $INPUT, $OUTPUT, $front, $mode, $filename, $tmpdir);
>  
>  if($ARGV[0] eq ""){
>    die "Usage: makeman [convert | install] <dir> <file>\n";
> @@ -132,9 +132,13 @@
>        }
>      }
>      close INPUT;
> -
> -    system("cd $ARGV[1]; docbook2man $filename.sgml; mv $filename.9 /tmp/$$.9\n");
> -    open GENERATED, "< /tmp/$$.9";
> +    if($ENV{'TMPDIR'}) {
> +        $tmpdir=$ENV{'TMPDIR'};
> +    } else {
> +        $tmpdir="/tmp";
> +    }
> +    system("cd $ARGV[1]; docbook2man $filename.sgml; mv $filename.9 $tmpdir/$$.9\n");
> +    open GENERATED, "< $tmpdir/$$.9";
>      open OUTPUT, "> $ARGV[1]/$filename.9";
>  
>      print OUTPUT "$front";
> @@ -146,7 +150,7 @@
>      close GENERATED;
>  
>      system("gzip -f $ARGV[1]/$filename.9\n");
> -    unlink("/tmp/$filename.9");
> +    unlink("$tmpdir/$filename.9");
>    }
>  }
>  elsif($ARGV[0] eq "install"){
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
