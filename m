Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSH0T6m>; Tue, 27 Aug 2002 15:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSH0T6l>; Tue, 27 Aug 2002 15:58:41 -0400
Received: from ns.suse.de ([213.95.15.193]:18182 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317170AbSH0T6i>;
	Tue, 27 Aug 2002 15:58:38 -0400
To: Dean Nelson <dcn@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: atomic64_t proposal
References: <200208271937.OAA78345@cyan.americas.sgi.com>
X-Yow: Yow!  I want to mail a bronzed artichoke to Nicaragua!
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 27 Aug 2002 22:02:57 +0200
In-Reply-To: <200208271937.OAA78345@cyan.americas.sgi.com> (Dean Nelson's
 message of "Tue, 27 Aug 2002 14:37:27 -0500 (CDT)")
Message-ID: <je1y8kgjda.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dean Nelson <dcn@sgi.com> writes:

|> +#define ia64_atomic_add(i,v)						\
|> +({									\
|> +	__typeof__((v)->counter) _old, _new;				\
|> +	CMPXCHG_BUGCHECK_DECL						\
|> +									\
|> +	do {								\
|> +		CMPXCHG_BUGCHECK(v);					\
|> +		_old = atomic_read(v);					\
|> +		_new = _old + (i);					\
|> +	} while (ia64_cmpxchg("acq", (v), _old, _new, sizeof(*(v))) != _old); \
|> +	(__typeof__((v)->counter)) _new;	/* return new value */	\

What's the purpose of the cast here? The type of _new is already the
right one.

|>  #define atomic_add_return(i,v)						\
|>  	((__builtin_constant_p(i) &&					\
|>  	  (   (i ==  1) || (i ==  4) || (i ==  8) || (i ==  16)		\
|>  	   || (i == -1) || (i == -4) || (i == -8) || (i == -16)))	\
|>  	 ? ia64_fetch_and_add(i, &(v)->counter)				\
|> -	 : ia64_atomic_add(i, v))
|> +	 : ia64_atomic_add((i), (v)))

The extra parens are useless.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
