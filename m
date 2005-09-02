Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVIBKmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVIBKmg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 06:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbVIBKmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 06:42:36 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:37537 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030240AbVIBKmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 06:42:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=P7VR8aAIuOom75aTDEXDvtP9eUZk2CEOYkF9If0roOu5184Qpz01ThWJLduFf+T9MTUEI5Aw+JqD/3YBG9HsqAtIwnAx6C2YjRJxOPK783yH0COSI/7K/52OXDtUiaZVF1UevTMOuLREw4J4zC5molmZSJHQcCSuSjOCP6HDTmU=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 10/12] UML - Allow host capability usage to be disabled
Date: Fri, 2 Sep 2005 12:39:23 +0200
User-Agent: KMail/1.8.1
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <200509012217.j81MHKE7011567@ccure.user-mode-linux.org>
In-Reply-To: <200509012217.j81MHKE7011567@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509021239.23859.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 September 2005 00:17, Jeff Dike wrote:
> From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>
> Add new cmdline setups:
>   - noprocmm
>   - noptracefaultinfo
> In case of testing, they can be used to switch off usage of
> /proc/mm and PTRACE_FAULTINFO independently.
Is "skas0" cmd line option preserved?
> Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>
> Index: test/arch/um/os-Linux/start_up.c
> ===================================================================
> --- test.orig/arch/um/os-Linux/start_up.c	2005-09-01 16:42:42.000000000
> -0400 +++ test/arch/um/os-Linux/start_up.c	2005-09-01 16:51:23.000000000
> -0400 @@ -275,6 +275,30 @@
>  	check_ptrace();
>  }
>
> +static int __init noprocmm_cmd_param(char *str, int* add)
> +{
> +	proc_mm = 0;
> +	return 0;
> +}
> +
> +__uml_setup("noprocmm", noprocmm_cmd_param,
> +"noprocmm\n"
> +"    Turns off usage of /proc/mm, even if host supports it.\n"
> +"    To support /proc/mm, the host needs to be patched using\n"
> +"    the current skas3 patch.\n\n");
> +
> +static int __init noptracefaultinfo_cmd_param(char *str, int* add)
> +{
> +	ptrace_faultinfo = 0;
> +	return 0;
> +}
> +
> +__uml_setup("noptracefaultinfo", noptracefaultinfo_cmd_param,
> +"noptracefaultinfo\n"
> +"    Turns off usage of PTRACE_FAULTINFO, even if host supports\n"
> +"    it. To support PTRACE_FAULTINFO, the host needs to be patched\n"
> +"    using the current skas3 patch.\n\n");
> +
>  #ifdef UML_CONFIG_MODE_SKAS
>  static inline void check_skas3_ptrace_support(void)
>  {
>
>
>
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
