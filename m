Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVACBFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVACBFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 20:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVACBFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 20:05:24 -0500
Received: from dialin-145-254-060-068.arcor-ip.net ([145.254.60.68]:9994 "EHLO
	spit.home") by vger.kernel.org with ESMTP id S261276AbVACBFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 20:05:18 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kconfig: avoid temporary file
Date: Mon, 3 Jan 2005 01:55:04 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20041230235146.GA9450@mars.ravnborg.org> <20041230235216.GB9450@mars.ravnborg.org>
In-Reply-To: <20041230235216.GB9450@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501030155.05203.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 31 December 2004 00:52, Sam Ravnborg wrote:

> # scripts/kconfig/mconf.c
> #   2004/12/30 22:29:51+01:00 sam@mars.ravnborg.org +78 -28
> #   introduce a general growable string.
> #   Allow us to skip one additional temporary file

I'm not really against the change, but the reason is weird. In the end the 
string is still written to a file anyway...

> +/* Growable string. Allocates memory as needed when string expands */
> +struct gstr {
> + char *s;
> + size_t len;
> +};

I would prefer something more like this:

struct gstr {
 int size;
 char s[0];
};

and this would be better names for the functions:

struct gstr *str_new(void);
void str_free(struct gstr *gs);
void str_append(struct gstr *gs, const char *s);

It would be useful to have these sort of functions in the library, so we can 
e.g. use them to dynamically generate the help text.

bye, Roman
