Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287297AbSAHLeN>; Tue, 8 Jan 2002 06:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbSAHLeD>; Tue, 8 Jan 2002 06:34:03 -0500
Received: from mxzilla2.xs4all.nl ([194.109.6.50]:49418 "EHLO
	mxzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287297AbSAHLdr>; Tue, 8 Jan 2002 06:33:47 -0500
Date: Tue, 8 Jan 2002 12:33:32 +0100
From: jtv <jtv@xs4all.nl>
To: mike stump <mrs@windriver.com>
Cc: Dautrevaux@microprocess.com, dewar@gnat.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020108123332.D11855@xs4all.nl>
In-Reply-To: <200201080016.QAA12225@kankakee.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201080016.QAA12225@kankakee.wrs.com>; from mrs@windriver.com on Mon, Jan 07, 2002 at 04:16:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 04:16:32PM -0800, mike stump wrote:
> 
> I assume you meant something like this:
> 
> char * volatile cp;
> 
> main() {
>   return cp - cp;
> }

No.  No.  In this case you're giving cp external linkage, which means it
can be observed from the outside.  Plus, you're reading it multiple times,
which in the case of volatile definitely means it should be read multiple
times because it might be modified by something external between those
reads, and that may be exactly what you want to observe with your code.

What I mean (and what we're seeing in RELOC) is more like this:

char *foo() {
  char * volatile cp = NULL;
  return cp;
}


Jeroen

