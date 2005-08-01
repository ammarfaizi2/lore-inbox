Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVHAHgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVHAHgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVHAHgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:36:12 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:37116 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262419AbVHAHgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:36:04 -0400
Date: Mon, 1 Aug 2005 09:35:58 +0200
From: David Weinehall <tao@acc.umu.se>
To: Karim Yaghmour <karim@opersys.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Average instruction length in x86-built kernel?
Message-ID: <20050801073558.GI9841@khan.acc.umu.se>
Mail-Followup-To: Karim Yaghmour <karim@opersys.com>,
	Ingo Oeser <ioe-lkml@rameria.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <42EAA05F.4000704@opersys.com> <200507301549.32528.ioe-lkml@rameria.de> <42EBDBA5.5090008@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EBDBA5.5090008@opersys.com>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 03:57:25PM -0400, Karim Yaghmour wrote:
[snip]
> # Remove non-instruction lines:
> sed /^[^c].*/d $2-dissassembled-kernel > $2-stage-1
> 
> # Remove empty lines:
> sed /^'\t'*$/d $2-stage-1 > $2-stage-2
> 
> # Remove function names:
> sed /^c[0-9,a-f]*' '\<.*\>:$/d $2-stage-2 > $2-stage-3
> 
> # Remove addresses:
> sed s/^c[0-9,a-f]*:'\t'// $2-stage-3 > $2-stage-4
> 
> # Remove instruction text:
> sed s/'\t'.*// $2-stage-4 > $2-stage-5
> 
> # Remove trailing whitespace:
> sed s/'\s'*$// $2-stage-5 > $2-stage-6

Uhm, you do know that sed allows you to execute several commands after
eachother, right?

sed -e 's/foo/bar/;s/baz/omph/'

That way you should be able to save a few stages.
Also, your script is, as far as I could see, a clean sh-script;
no need for /bin/bash; use /bin/sh instead.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
