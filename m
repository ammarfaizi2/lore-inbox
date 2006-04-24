Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWDXRRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWDXRRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWDXRRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:17:31 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:29796 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750837AbWDXRRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:17:30 -0400
In-Reply-To: <200604220030.29214.ioe-lkml@rameria.de>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       "Pekka Enberg" <penberg@cs.helsinki.fi>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF346B0EC4.22389E6C-ON4225715A.00553273-4225715A.005EFC07@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Mon, 24 Apr 2006 19:17:29 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 24/04/2006 19:18:32
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Ingo Oeser <ioe-lkml@rameria.de> wrote on 04/22/2006 12:30:28 AM:
>
> Nearly.
>
> - Just return the *ptr and let the caller modify the string.
> - Take a string with characters to reject
>
> Reasons:
>    - string might be read only
>    - caller wants to copy it anyway
>    - string might be a substring or sth. we like to parse further
>    - Symmetry with strchr()
>
> Otherwise it is a very good idea implemented in a patch similiar to this
> untested one below against Linus' current tree.
>
> use case would be:
> char *s = strltrim(string, " \t");
> char *e = strrtrim(s, " \t\n\r");
> *e = '\0';

I agree that it is a good idea to specify the characters to
reject, but I would like to use the function without having an
additional local pointer variable. In my opinion this
functionality is enough for most cases.

What about something like that:

/**
 * strrtrim - Remove trailing characters specified in @reject
 * @s: The string to be searched
 * @reject: The string of letters to avoid
 */
static inline void strrtrim(char *s, const char *reject)
{
      char *p;
      const char *r;

      for (p = s + strlen(s) - 1; s <= p; p--) {
            for (r = reject; (*r != '\0') && (*p != *r); r++)
                  /* nothing */;
            if (*r == '\0')
                  break;
      }
      *(p + 1) = '\0';
}

Regards
Michael

