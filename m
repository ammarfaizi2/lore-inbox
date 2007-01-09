Return-Path: <linux-kernel-owner+w=401wt.eu-S932521AbXAIXZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbXAIXZ5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbXAIXZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:25:57 -0500
Received: from 1wt.eu ([62.212.114.60]:1881 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932521AbXAIXZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:25:56 -0500
Date: Wed, 10 Jan 2007 00:25:34 +0100
From: Willy Tarreau <w@1wt.eu>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: .version keeps being updated
Message-ID: <20070109232534.GV24090@1wt.eu>
References: <20070109102057.c684cc78.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109102057.c684cc78.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean !

On Tue, Jan 09, 2007 at 10:20:57AM +0100, Jean Delvare wrote:
> Hi all,
> 
> Since 2.6.20-rc1 or so, running "make" always builds a new kernel with
> an incremented version number, whether there has actually been any
> change done to the code or configuration or not. This increases the
> build time quite a bit.
> 
> I've tracked it down to include/linux/compile.h always being updated,
> and this is because .version is updated. I couldn't find what is
> causing .version to be updated each time though. Can anybody help
> there? Was this change made on purpose or is this a bug which we should
> fix?

it contains the build number (#X). You have it in the Makefile :
"expr 0$$(cat .old_version) + 1 >.version". I think you can block it
with a "chattr +i .version" and see if make complains.

Regards,
Willy

