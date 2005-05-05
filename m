Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVEEXVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVEEXVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 19:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVEEXVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 19:21:43 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64961 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261882AbVEEXVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 19:21:41 -0400
Date: Thu, 5 May 2005 16:21:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James Cloos <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: from line script for git commits
Message-ID: <20050505232139.GD1221@smtp.west.cox.net>
References: <m3ekd326y1.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ekd326y1.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 04:47:18PM -0400, James Cloos wrote:

> I've been using a script grabbed from here for some time to alter
> the From: line on mail sent to bk-head-commits and bk-24-commits
> to show the author's name and email rather than LKML's address.
> 
> Below is my script for doing the same with git commit emails.

Ages ago I grabbed a different one for fixing up BK.  Here's what I've
got now that fixes up both (and munges the date on git, which may or may
not turn out to be useful).

#!/bin/sh

TMP=`mktemp /tmp/setfrom.XXXXXX`
cat > $TMP

## Old BitKeeper logic
from=`grep '^ChangeSet' $TMP | head -1 | awk '{print $NF}'`

## New git logic
author=`sed -n '/^author /p' < $TMP | head -n 1`
if [ ! -z "$author" ]; then
  from=`echo $author | sed 's/author \(.*>\).*/\1/'`
  date=`echo $author | sed 's/author.*> //'`
fi
if test -n "$from" -a -n "$date"; then
  formail -I "From: $from" -I "Date: `date -d "$date" -R`" < $TMP
else
  if test -n "$from"; then
    formail -I "From: $from" < $TMP
  else
    cat $TMP
  fi
fi

rm $TMP

-- 
Tom Rini
http://gate.crashing.org/~trini/
