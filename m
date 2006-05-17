Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWEQMys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWEQMys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWEQMys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:54:48 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:19010 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932261AbWEQMys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:54:48 -0400
Subject: Re: [RFC] [Patch 2/8] statistics infrastructure - prerequisite:
	parser enhancement
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060516111141.1cff68e9.akpm@osdl.org>
References: <446A0FBE.2030105@de.ibm.com>
	 <20060516111141.1cff68e9.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 17 May 2006 14:54:36 +0200
Message-Id: <1147870476.6361.20.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 11:11 -0700, Andrew Morton wrote:
> Your email client does space-stuffing, so this won't apply (ok, it might
> apply if my email client knew how to space-unstuff, but it doesn't).

Okay, I got rid of my email client's space-stuffing (and of my former
email client, for that matter). I will resend my patches.

> > diff -Nurp a/lib/parser.c b/lib/parser.c
> > --- a/lib/parser.c	2006-03-20 06:53:29.000000000 +0100
> > +++ b/lib/parser.c	2006-05-15 17:56:25.000000000 +0200
> > @@ -140,6 +140,64 @@ static int match_number(substring_t *s,
> >   }
> > 
> >   /**
> > + * match_u64: scan a number in the given base from a substring_t
> > + * @s: substring to be scanned
> > + * @result: resulting integer on success
> > + * @base: base to use when converting string
> > + *
> > + * Description: Given a &substring_t and a base, attempts to parse the substring
> > + * as a number in that base. On success, sets @result to the u64 represented
> > + * by the string and returns 0. Returns either -ENOMEM or -EINVAL on failure.
> > + */
> > +int match_u64(substring_t *s, u64 *result, int base)
> > +{
> > +	char *endp;
> > +	char *buf;
> > +	int ret;
> > +
> > +	buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +	memcpy(buf, s->from, s->to - s->from);
> > +	buf[s->to - s->from] = '\0';
> > +	*result = simple_strtoull(buf, &endp, base);
> > +	ret = 0;
> > +	if (endp == buf)
> > +		ret = -EINVAL;
> > +	kfree(buf);
> > +	return ret;
> > +}
> > +
> > +/**
> > + * match_s64: scan a number in the given base from a substring_t
> > + * @s: substring to be scanned
> > + * @result: resulting integer on success
> > + * @base: base to use when converting string
> > + *
> > + * Description: Given a &substring_t and a base, attempts to parse the substring
> > + * as a number in that base. On success, sets @result to the s64 represented
> > + * by the string and returns 0. Returns either -ENOMEM or -EINVAL on failure.
> > + */
> > +int match_s64(substring_t *s, s64 *result, int base)
> > +{
> > +	char *endp;
> > +	char *buf;
> > +	int ret;
> > +
> > +	buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +	memcpy(buf, s->from, s->to - s->from);
> > +	buf[s->to - s->from] = '\0';
> > +	*result = simple_strtoll(buf, &endp, base);
> > +	ret = 0;
> > +	if (endp == buf)
> > +		ret = -EINVAL;
> > +	kfree(buf);
> > +	return ret;
> > +}
> 
> These are identical.  If we _really_ need one for signed and one for
> unsigned then we could at least do

I am going to remove match_u64. My code doesn't use it anymore.

