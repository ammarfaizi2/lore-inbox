Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289191AbSAIHZj>; Wed, 9 Jan 2002 02:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289187AbSAIHZ3>; Wed, 9 Jan 2002 02:25:29 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:17679 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288802AbSAIHZ1>;
	Wed, 9 Jan 2002 02:25:27 -0500
Date: Tue, 8 Jan 2002 23:23:13 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
Message-ID: <20020109072313.GA18359@kroah.com>
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com> <20020108235649.A26154@xs4all.nl> <20020108231147.GA16313@kroah.com> <20020108181202.A986@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020108181202.A986@twiddle.net>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 12 Dec 2001 05:15:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 06:12:02PM -0800, Richard Henderson wrote:
> 
> __FUNCTION__ was never a string literal in g++ because you can't decide
> what the name of a template is until you instantiate it.

According to the info page it was:
	   The compiler automagically replaces the identifiers with a
	   string literal containing the appropriate name. 

This is written right after a lovely C++ example of using __FUNCTION__
and __PRETTY_FUNCTION__.  But I can understand the difficulties of
determining this for some C++ cases.

> Having __FUNCTION__ be a magic cpp thingy means there is a translation
> phase violation.  Preprocessor macros are expanded in phase 4, string
> concatenation happens in phase 6, syntactic and symantic analysis
> doesn't happen until phase 7.
> 
> So changing this allows us to change two things: (1) the integrated
> preprocessor can concatenate adjacent string literals and do lexical
> analysis exactly as described in the standard, and (2) removes an
> irrelevant difference between c and c++ so that at some point we can
> support both with a single front-end.

So, if you are going to change this (well, sounds like it is already
done), what is the timeline from taking a well documented feature and
breaking it (based on the example in the info page)?  First a warning,
and then an error, right?  What version of the compiler emits a warning,
and what future version will emit an error?  I didn't see anything about
these kinds of changes in the gcc development plan, or am I missing some
documentation somewhere?

thanks,

greg k-h
