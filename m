Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTKPQKH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 11:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbTKPQKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 11:10:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64938 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262901AbTKPQKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 11:10:00 -0500
Date: Sun, 16 Nov 2003 16:09:58 +0000
From: Matthew Wilcox <willy@debian.org>
To: Will Dyson <will_dyson@pobox.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add lib/parser.c kernel-doc
Message-ID: <20031116160958.GW30485@parcelfarce.linux.theplanet.co.uk>
References: <1068970562.19499.11.camel@thalience>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068970562.19499.11.camel@thalience>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 16, 2003 at 03:16:03AM -0500, Will Dyson wrote:
> +// associates an integer enumerator with a pattern string.

Please no C++ comments.

> -int match_int(substring_t *, int *result);
> -int match_octal(substring_t *, int *result);
> -int match_hex(substring_t *, int *result);
> -void match_strcpy(char *, substring_t *);
> -char *match_strdup(substring_t *);
> +int match_int(substring_t *s, int *result);
> +int match_octal(substring_t *s, int *result);
> +int match_hex(substring_t *s, int *result);
> +void match_strcpy(char *to, substring_t *s);
> +char *match_strdup(substring_t *s);

What value does this "s" add?  "result" is clearly useful documentation,
but "s" says "There is no good name for this variable"

> @@ -74,6 +85,20 @@
>  	}
>  }
>  
> +/**
> + * match_token: - Find a token (and optional args) in a string
> + * @s: the string to examine for token/argument pairs
> + * @table: match_table_t describing the set of allowed option tokens
> and the
> + * arguments that may be associated with them. Must be terminated with
> a
> + * &struct match_token who's pattern is set to the NULL pointer.

whose

> + * @args: array of %MAX_OPT_ARGS &substring_t elements. Used to return
> match
> + * locations.
> + *
> + * Description: Detects which if any of a set of token strings has been
> passed
> + * to it. Tokens can include up to MAX_OPT_ARGS instances of basic
> c-style
> + * format identifiers which will be taken into account when matching
> the
> + * tokens, and who's locations will be returned in the @args array.

ditto

> +/**
> + * match_strdup: - allocate a new c-string with the contents of a

Umm.  We're writing in C.  Just plain "string" is fine.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
