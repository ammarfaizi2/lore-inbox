Return-Path: <linux-kernel-owner+w=401wt.eu-S932382AbXAGEC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbXAGEC1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 23:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbXAGEC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 23:02:27 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:48811 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbXAGEC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 23:02:26 -0500
Date: Sat, 6 Jan 2007 20:00:45 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>, akpm <akpm@osdl.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Discuss a couple common errors in kernel-doc usage.
Message-Id: <20070106200045.43683769.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0701051000560.3949@localhost.localdomain>
References: <Pine.LNX.4.64.0701051000560.3949@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007 10:03:53 -0500 (EST) Robert P. J. Day wrote:

> 
>   Explain a couple of the most common errors in kernel-doc usage.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

It seems that you have been looking at my kdoc todo list....


> ---
> 
>   seems useful to emphasize these issues since they occur occasionally
> in the source.
> 
> diff --git a/Documentation/kernel-doc-nano-HOWTO.txt b/Documentation/kernel-doc-nano-HOWTO.txt
> index 284e7e1..ba50129 100644
> --- a/Documentation/kernel-doc-nano-HOWTO.txt
> +++ b/Documentation/kernel-doc-nano-HOWTO.txt
> @@ -107,10 +107,14 @@ The format of the block comment is like this:
>   * (section header: (section description)? )*
>  (*)?*/
> 
> -The short function description cannot be multiline, but the other
> -descriptions can be (and they can contain blank lines). Avoid putting a
> -spurious blank line after the function name, or else the description will
> -be repeated!
> +The short function description ***cannot be multiline***, but the other
> +descriptions can be (and they can contain blank lines).  If you continue
> +that initial short description onto a second line, that second line will
> +appear further down at the beginning of the description section, which is
> +almost certainly not what you had in mind.
> +
> +Avoid putting a spurious blank line after the function name, or else the
> +description will be repeated!
> 
>  All descriptive text is further processed, scanning for the following special
>  patterns, which are highlighted appropriately.
> @@ -121,6 +125,31 @@ patterns, which are highlighted appropriately.
>  '@parameter' - name of a parameter
>  '%CONST' - name of a constant.
> 
> +NOTE 1:  The multi-line descriptive text you provide does *not* recognize
> +line breaks, so if you try to format some text nicely, as in:
> +
> +  Return codes
> +    0 - cool
> +    1 - invalid arg
> +    2 - out of memory
> +
> +this will all run together and produce:
> +
> +  Return codes 0 - cool 1 - invalid arg 2 - out of memory
> +
> +NOTE 2:  If the descriptive text you provide has lines that begin with
> +some phrase followed by a colon, each of those phrases will be taken as
> +a new section heading, which means you should similarly try to avoid text
> +like:
> +
> +  Return codes:
> +    0: cool
> +    1: invalid arg
> +    2: out of memory
> +
> +every line of which would start a new section.  Again, probably not
> +what you were after.
> +
>  Take a look around the source tree for examples.
> 
> 
> -

---
~Randy
