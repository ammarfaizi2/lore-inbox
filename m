Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbTDKH1T (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 03:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTDKH1T (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 03:27:19 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:44079 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S264307AbTDKH1R (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 03:27:17 -0400
Date: Fri, 11 Apr 2003 10:38:50 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-english user messages
Message-ID: <20030411073849.GU159052@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
	'Chuck Ebbert' <76306.1226@compuserve.com>,
	'linux-kernel' <linux-kernel@vger.kernel.org>
References: <A46BBDB345A7D5118EC90002A5072C780BEBA7DD@orsmsx116.jf.intel.com> <20030410160636.H26054@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030410160636.H26054@schatzie.adilger.int>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 04:06:36PM -0600, you [Andreas Dilger] wrote:
>
>   From what I've read, it sounds like the solution that will be accepted by
> the kernel developers is that kernel messages will continue to be output
> as-is in english, and can be post-processed with a tool to translate it to
> another language.  The tool will grab the format strings from the kernel
> so that it can separate out the constant and variable parts of the message,
> and the format strings will be translated.
> 
> At translation time, _something_ _like_ "sscanf(format_string, ...)" will
> be used to detect the which message is which (probably being speeded up
> with a pattern-matching hash of the constant parts of the message like
> prcs/xdelta does), substituting the english format with the translated
> format, and then substituting the args.

But the sscanf parsing is fragile if not impossible to get right in some
cases. How do you parse the output of printk("file %s on device %s
corrupted", file, devname); if file the file contains spaces and whatever?

Why not make it so that kernel can be configured to output messages as
<format string>,<arg>,<arg>... where the format string is what is usually
passed to *printf. (The actual field separators could be \0 or something.)
Then you can use standard gnu gettext to get the translation in user space
(i18n aware klogd, whatever) and apply the formatting after that.

Actually, the structured message pool could be separate from the normal one,
so that the existing tools don't break. Both the old style and formatted
message pool could be configured on and off based on user needs when
compiling the kernel. 

And the change should be pretty easy and centralized in kernel. This only
adds the run time over head of maintaing two pools iff both are configured
on.

(Not that I need i18n kernel or would ever use one. And I'm fairly sure
no-one gets around to implement it anyway...)


-- v --

v@iki.fi
