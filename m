Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266849AbUHOTQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266849AbUHOTQL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 15:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266851AbUHOTQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 15:16:11 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:33177 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266849AbUHOTQE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 15:16:04 -0400
Date: Sun, 15 Aug 2004 21:18:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Bogus "has no CRC" in external module builds
Message-ID: <20040815191839.GE7682@mars.ravnborg.org>
Mail-Followup-To: Pavel Roskin <proski@gnu.org>,
	linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <Pine.LNX.4.58.0404291246220.7129@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404291246220.7129@marabou.research.att.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 02:45:30PM -0400, Pavel Roskin wrote:
> Hello!
> 
> The recent fixes for the external module build have fixed the major
> breakage, but they left one annoyance unfixed.  If CONFIG_MODVERSIONS is
> disabled, a warning is printed for every exported symbol that is has no
> CRC.  For instance, I see this when compiling the standalone Orinoco
> driver on Linux 2.6.6-rc3:
> 
> *** Warning: "__orinoco_down" [/usr/local/src/orinoco/spectrum_cs.ko] has
> no CRC!
> *** Warning: "hermes_struct_init" [/usr/local/src/orinoco/spectrum_cs.ko]
> has no CRC!
> *** Warning: "free_orinocodev" [/usr/local/src/orinoco/spectrum_cs.ko] has
> no CRC!
> [further warnings skipped]
> 
> I have found that the "-i" option for modpost is used for external builds,
> whereas the internal modules use "-o".  The "-i" option causes read_dump()
> in modpost.c to be called.  This function sets "modversions" variable
> under some conditions that I don't understand.  The comment before the
> modversions declarations says: "Are we using CONFIG_MODVERSIONS?"
> 
> Apparently modpost fails to answer this question.  I think it's better to
> use an explicit option rather than a kludge.
> 
> The attached patch adds a new option "-m" that is specified if and only if
> CONFIG_MODVERSIONS is enabled.  The patch has been successfully tested
> both with and without CONFIG_MODVERSIONS.

Applied a handedited version of this to my tree - sorry for the dealy.

	Sam
