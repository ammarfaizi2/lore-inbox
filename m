Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273666AbRI0Q2K>; Thu, 27 Sep 2001 12:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273680AbRI0Q2A>; Thu, 27 Sep 2001 12:28:00 -0400
Received: from ns.suse.de ([213.95.15.193]:2062 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S273666AbRI0Q1l> convert rfc822-to-8bit;
	Thu, 27 Sep 2001 12:27:41 -0400
To: James Antill <james@and.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre11 -- __builtin_expect
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org.suse.lists.linux.kernel>
	<E15jBLy-0008UF-00@the-village.bc.nu.suse.lists.linux.kernel>
	<9o6j9l$461$1@cesium.transmeta.com.suse.lists.linux.kernel>
	<oup4rq0bwww.fsf_-_@pigdrop.muc.suse.de>
	<jeelp4rbtf.fsf@sykes.suse.de>
	<20010918143827.A16003@gruyere.muc.suse.de>
	<nn3d59qzho.fsf@code.and.org> <jezo7gu78f.fsf@sykes.suse.de>
	<nnvgi4prod.fsf@code.and.org>
X-Yow: All this time I've been VIEWING a RUSSIAN MIDGET SODOMIZE a HOUSECAT!
From: Andreas Schwab <schwab@suse.de>
Date: 27 Sep 2001 18:28:08 +0200
In-Reply-To: <nnvgi4prod.fsf@code.and.org> (James Antill's message of "27 Sep 2001 11:41:22 -0400")
Message-ID: <jeofnwsinb.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.107
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Antill <james@and.org> writes:

|> Andreas Schwab <schwab@suse.de> writes:
|> 
|> > James Antill <james@and.org> writes:
|> > 
|> > |>  unlikely() also needs to be...
|> > |> 
|> > |> #define unlikely(x)  __builtin_expect(!(x), 1) 
|> > |> 
|> > |> ...or...
|> > |> 
|> > |> #define unlikely(x)  __builtin_expect(!!(x), 0) 
|> > 
|> > This is not needed, since only 0 is the likely value and !! does not
|> > change that.
|> 
|>  Yes it is, given the code...
|> 
|> struct blah *ptr = NULL;
|> 
|> if (unlikely(ptr))
|> 
|> ...you'll get a warning from gcc because you are implicitly converting
|> from a pointer to a long.

You're right, seems like __builtin_expect is really only defined for pure
boolean values.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
