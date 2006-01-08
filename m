Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWAHSx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWAHSx1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWAHSx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:53:27 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:61242 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1161032AbWAHSx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:53:26 -0500
Date: Sun, 08 Jan 2006 13:53:01 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-reply-to: <200601081734.30349.zippel@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1136746381.1043.10.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL003ZI97GCY@a34-mta01.direcway.com>
 <200601081734.30349.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 17:34 +0100, Roman Zippel wrote:
> Hi,
> 
> On Wednesday 04 January 2006 23:01, Ben Collins wrote:
> 
> > +static char *fgets_check_stream(char *s, int size, FILE *stream)
> > +{
> > +	char *ret = fgets(s, size, stream);
> > +
> > +	if (ret == NULL && feof(stream)) {
> > +		printf(_("aborted!\n\n"));
> > +		printf(_("Console input is closed. "));
> > +		printf(_("Run 'make oldconfig' to update configuration.\n\n"));
> > +		exit(1);
> > +	}
> > +
> > +	return ret;
> > +}
> 
> What problem does this solve? conf should finish normally anyway and just set 
> everything to the default.

It shouldn't, and it doesn't (that's what defconfig does, I believe).

Anyway, the problem is that if there is no terminal (e.g. stdout is
redirected to a file, and stdin is closed), then kconf loops forever
trying to get an answer (NULL is not the same as "").

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

