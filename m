Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUHTElU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUHTElU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 00:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267351AbUHTElU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 00:41:20 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:4937 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267335AbUHTElS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 00:41:18 -0400
Date: Fri, 20 Aug 2004 08:41:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: GNU make alleged of "bug" (was: PATCH: cdrecord: avoiding scsi device numbering for ide devices)
Message-ID: <20040820064137.GA7279@mars.ravnborg.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <200408191600.i7JG0Sq25765@tag.witbe.net> <200408191341.07380.gene.heskett@verizon.net> <20040819194724.GA10515@merlin.emma.line.org> <20040819220553.GC7440@mars.ravnborg.org> <20040819205301.GA12251@merlin.emma.line.org> <41252A30.nail8D551I5Z2@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41252A30.nail8D551I5Z2@burner>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 12:31:12AM +0200, Joerg Schilling wrote:
 
> -include does not work with Sun's make and it does not cure the bug in GNU make
> but hides it only.
> 
> GNU make just violates the unwritten "golden rule" for all make programs:
> 
> 	If you like to "use" anything, first check whether you have a rule
> 	that could make the file in question.
> 
> For makefiles on the Command Line, GNU make follows this rule. If you are in an 
> empty directory and call "gmake", GNU make will first try if "Makefile" or 
> "makefile" could be retrieved using e.g. "sccs get Makefile" before GNU make 
> tries to read the file.
> 
> For makefiles that appear as argument to an include statement, GNU make ingnores
> this rule. GNU make instead, later (too late) executes the rule set and creates 
> the missing files using known rules. In order to be able to do anything useful, 
> GNU make then executes "exec gmake <old arg list>" after it is done with 
> executing the rules. This is complete nonsense.
> 
> Smake works this way:
> 
> -	if it is going to "include" a file, it checks whether there is a rule 
> 	to make the file that is going to be included.
> 
> -	If the file has been "made", smake includes the file.
> 
> -	After including the file, smake clears the "has been made already" 
> 	cache flags for the included file.
> 
> -	After all make files and all recursive include rules have been made and 
> 	included, smake checks all rules again. This may result in rare cases 
> 	that the rule for one of the the include file is executed again.
> 
> As you noe see that GNU make behaves inconsistent, I hope you believe me that 
> there is a bug in GNU make that should be fixed.

Please post this on the make-bug list then.

	Sam
