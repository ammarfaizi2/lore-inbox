Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288716AbSAICMe>; Tue, 8 Jan 2002 21:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288717AbSAICMX>; Tue, 8 Jan 2002 21:12:23 -0500
Received: from are.twiddle.net ([64.81.246.98]:60802 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S288716AbSAICMI>;
	Tue, 8 Jan 2002 21:12:08 -0500
Date: Tue, 8 Jan 2002 18:12:02 -0800
From: Richard Henderson <rth@twiddle.net>
To: Greg KH <greg@kroah.com>
Cc: jtv <jtv@xs4all.nl>, Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
Message-ID: <20020108181202.A986@twiddle.net>
Mail-Followup-To: Greg KH <greg@kroah.com>, jtv <jtv@xs4all.nl>,
	Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com> <20020108235649.A26154@xs4all.nl> <20020108231147.GA16313@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020108231147.GA16313@kroah.com>; from greg@kroah.com on Tue, Jan 08, 2002 at 03:11:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 03:11:47PM -0800, Greg KH wrote:
> Any reason _why_ they would want to break tons of existing code in this
> manner?

__FUNCTION__ was never a string literal in g++ because you can't decide
what the name of a template is until you instantiate it.

Having __FUNCTION__ be a magic cpp thingy means there is a translation
phase violation.  Preprocessor macros are expanded in phase 4, string
concatenation happens in phase 6, syntactic and symantic analysis
doesn't happen until phase 7.

So changing this allows us to change two things: (1) the integrated
preprocessor can concatenate adjacent string literals and do lexical
analysis exactly as described in the standard, and (2) removes an
irrelevant difference between c and c++ so that at some point we can
support both with a single front-end.


r~
