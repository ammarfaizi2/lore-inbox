Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422738AbWGNUBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422738AbWGNUBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422737AbWGNUBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:01:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:62900 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422671AbWGNUBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:01:36 -0400
Subject: Re: [RFC][PATCH 3/6] SLIM main patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1152901664.314.35.camel@localhost.localdomain>
References: <1152897878.23584.6.camel@localhost.localdomain>
	 <1152901664.314.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 13:01:41 -0700
Message-Id: <1152907301.23584.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 11:27 -0700, Dave Hansen wrote:

> > +static enum slm_iac_level set_iac(char *token)
> > +{
> > +	int iac;
> > +
> > +	if (memcmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
> > +		return SLM_IAC_EXEMPT;
> > +	else {
> 
> Might as well add brackets here.  Or, just kill the else{} block and
> pull the code back to the lower indenting level.  The else is really
> unnecessary because of the return;
> 
> > +		for (iac = 0; iac < sizeof(slm_iac_str) / sizeof(char *); iac++) {
> > +			if (memcmp(token, slm_iac_str[iac],
> > +				   strlen(slm_iac_str[iac])) == 0)
> > +				return iac;
> 
> Why not use strcmp?
> 
> > +static enum slm_sac_level set_sac(char *token)
> > +{
> > +	int sac;
> > +
> > +	if (memcmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
> > +		return SLM_SAC_EXEMPT;
> > +	else {
> > +		for (sac = 0; sac < sizeof(slm_sac_str) / sizeof(char *); sac++) {
> > +			if (memcmp(token, slm_sac_str[sac],
> > +				   strlen(slm_sac_str[sac])) == 0)
> > +				return sac;
> > +		}
> > +	}
> > +	return SLM_SAC_ERROR;
> > +}
> 
> This function looks awfully similar :).  Can you just pass that array in
> as an argument, and get rid of one of the functions?
> 
On closer look combining these would require collapsing them into one
enum or returning int and doing a bunch of casting.  Kind of seems to
void the point of using an enum.  Thus I propose leaving them as is,
okay?


