Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWINPVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWINPVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWINPVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:21:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:64248 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750767AbWINPVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:21:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iWyteiB6zuPIX2dM5gahjJqB4UejH9n18IY3SE1Xtq6ykOcuF14Aefze+ev5sWwocvOF8JXzVDYoskCcgIPHHYySuQmTgkBcDCtfY3wrPvZa+nRYVBE+xim4JmkqmuUM2SOzLP0fQwr9oK1K4mdVbUn7Fk7oGpgd7mmUccb1Id8=
Message-ID: <728201270609140821l7cf30578y2f45479b03e77f64@mail.gmail.com>
Date: Thu, 14 Sep 2006 10:21:03 -0500
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "linux mailing-list" <linux-kernel@vger.kernel.org>
Subject: support for limit of open file descriptors for a child process
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I came across a problem regarding the issue of number of open
file descriptors.The scenario is as below.
 I have a controlling process which launches other different
apllication including third party ones. It also enforces various
resource limits including number of open file descriptors. This
process forks & reads the resource limits from a configuration files,
applies the resource limits & then execs for the corresponding
application. The process has its own various number of open file
descriptors. If the limit of open file descriptor for the child
application is less than the number of file descriptors  of the parent
process, then the child application file can not be opened & exec
fails in this case.

I searched solution for this problem but could not find an existing
way to solve it. I thought of couple of ways to do it. One idea is to
create another flag for clone which makes it not to inherit the open
file descriptors & use clone with that flag instead of fork .The other
approach is to create a new system call & parent process can call that
system call before calling the setrlimit.

I am looking for your opinion about the better way . Further if it is helpful
 then I can submit the patch also.

Thanks in advance
regards
Ram Gupta
