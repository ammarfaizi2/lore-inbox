Return-Path: <linux-kernel-owner+w=401wt.eu-S1762369AbWLKAC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762369AbWLKAC4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 19:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762553AbWLKAC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 19:02:56 -0500
Received: from web55609.mail.re4.yahoo.com ([206.190.58.233]:32867 "HELO
	web55609.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1762369AbWLKACz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 19:02:55 -0500
Message-ID: <20061211000254.32230.qmail@web55609.mail.re4.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=oGAQxoLvJwHy6QQ7QIrBfw4ck6cvgEk+kuPug9ZgE2kyCysbIpGKX7GdYPggni66fCWo6GwcnnhWW9rlXMTWfCx6nDYAQkx5wC6Xtg9TXGXD0kIchSORnazCpD7JZTUZbbrrBF5IWopAZyYXyNaGm9a6BMxvmw+cxT8pJ9Y+sZo=;
X-YMail-OSG: 2UsIC6YVM1mk554eeVfl_mRFswnLFhqeZ19DZuL7bEFoxN705iQ3HZyZjxy.qdBmgpz9gogMEC1ug6xJwLKSGFEYvafvIFFJSG_DBp7hXMHTPXFgsqxImtxIvceoXAgP150mElTMXh9b7Ko-
Date: Sun, 10 Dec 2006 16:02:54 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: 2.6.19: slight performance optimization for lib/string.c's strstrip()
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Suggested replacement:
> 
> char *strstrip(char *s)
> {
> size_t size;
> char *end;
> 
> while (*s && isspace(*s))
> s++;
> if (!*s)
> return s;
> size = strlen(s);
> 
> end = s + size - 1;
> while (end > s && isspace(*end))
> end--;
> *(end + 1) = '\0';
> 
> return s;
> }
> EXPORT_SYMBOL(strstrip);

How about this:

char *strstrip(char *s)
{
        size_t less = 0;
        char c = 0;
        char *e = NULL;

        while ((c=*s) && isspace(c))
                s++;
        if (!c)
                return s;

        e = s;

        while (c=*e) {
                 less = isspace(c) ? (less + 1) : 0;
                 e++;
        }

        *(e-less) = 0;

        return s;
}

1. no need to scan trailing spaces twice (once in strlen and then again).
2. pointer dereference only once per loop rather than multiple times.

Regards,
Amit

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
