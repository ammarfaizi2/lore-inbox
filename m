Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUHEOn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUHEOn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267690AbUHEOml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:42:41 -0400
Received: from slartibartfast.pa.net ([66.59.111.182]:44985 "EHLO
	slartibartfast.pa.net") by vger.kernel.org with ESMTP
	id S267736AbUHEOh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:37:29 -0400
Date: Thu, 5 Aug 2004 10:34:11 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: John M Collins <jmc@xisl.com>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: Re: Program-invoking Symbolic Links?
In-Reply-To: <200408051504.26203.jmc@xisl.com>
Message-ID: <Pine.LNX.4.58.0408051027090.3293@sparrow>
References: <200408051504.26203.jmc@xisl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning, John,
	(My apologies for floating offtopic for kernel programming.  I 
wanted to provide a quick example for John and others interested in doing 
this so they could see this can be done outside of the kernel.)

On Thu, 5 Aug 2004, John M Collins wrote:

> (Please CC any reply to jmc AT xisl.com as I'm not subbed - thanks).
> 
> I wondered if anyone had ever thought of implementing an alternative form of 
> symbolic link which was in fact an invocation of a program?
> 
> Such a symbolic link would "do all the necessary" to fork off a new process 
> running the specified program with input or output from or to a pipe 
> depending on whether the link was opened for writing or reading respectively. 
> RW access would probably have to be banned and the link would usually be 
> read-only or write-only.
> 
> What I originally wanted was symbolic links (with "=>" as a possible 
> notation).
> 
> latest_version.tar => "tar cf - /latest/and/greatest"
> latest_version.tgz => "gzip -c latest_version"
> 
> and the like, which I could link on a website so I didn't have to run around 
> updating tar files/zip files/gzipped tar files etc each time I fix a bug in 
> some package.

	Is there any reason this couldn't be done in userspace by using 
named pipes instead of a new form of symlink?

#!/bin/bash

if [ ! -e livepipe ]; then
	echo Making livepipe >&2
	mkfifo livepipe
fi

while : ; do
	echo -n . >&2
	( date ) >livepipe
	sleep 1
done


	Run this, and then from another window, simply do:
cat livepipe
	To see the date, or whatever output is provided by the subshell.
	I'd like to sincerely request that further discussion _not_ 
continue on linux-kernel - please respond privately.
 	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Eagles may soar, high and proud, but weasels don't get sucked
into jet engines."
(Courtesy of Mike Andrews <mandrews@termfrost.org>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------
