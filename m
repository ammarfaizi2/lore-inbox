Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbQLVOdV>; Fri, 22 Dec 2000 09:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131437AbQLVOdM>; Fri, 22 Dec 2000 09:33:12 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:27264 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S131424AbQLVOcz>;
	Fri, 22 Dec 2000 09:32:55 -0500
Date: Fri, 22 Dec 2000 09:02:23 -0500 (EST)
From: pal@epoch.ncsc.mil (Pete Loscocco)
Message-Id: <200012221402.JAA11421@coalstack.epoch.ncsc.mil>
To: linux-kernel@vger.kernel.org
Subject: Security-enhanced Linux available at NSA site
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Information Assurance Research Office of the National Security
Agency is pleased to make available a prototype version of a
security-enhanced Linux system (http://www.nsa.gov/selinux). This
version of Linux has a strong, flexible mandatory access control
architecture incorporated into the major subsystems of the kernel.  The
system provides a mechanism to enforce the separation of information
based on confidentiality and integrity requirements. This allows
threats of tampering and bypassing of application security mechanisms
to be addressed and enables the confinement of damage that can be
caused by malicious or flawed applications.  The release also contains
configuration files as an example of a general-purpose security policy
configuration designed to address a number of security objectives. The
system is being released under the conditions of the GNU General Public
License.

Recognizing the critical role of operating system security mechanisms
in supporting security at higher levels, NSA researchers have been
investigating an operating system architecture that can provide the
necessary security functionality in a manner that can meet the security
needs of a wide range of computing environments. Previously, this
architecture was implemented for the Mach and Fluke operating systems.
It has now been integrated into Linux.

We chose Linux as the platform for our work because its growing
success and open development environment provide an excellent
opportunity to demonstrate that this functionality can be successful in
a mainstream operating system and, at the same time, contribute to the
security of a widely used system. We are not presenting this system as
a complete security solution for Linux, nor are we attempting to
correct any flaws that may currently exist in Linux.  Instead, we are
simply presenting an example of how mandatory access controls
that can confine the actions of any process, including a superuser
process, can be effectively added into Linux.  We feel that a Linux
implementation offers the best opportunity for this work to receive the
widest possible review and perhaps be the basis for additional
security research.

The security mechanisms implemented in the system provide flexible
support for a wide range of security policies. The currently implemented
access controls are a combination of type enforcement and role-based
access control. The specific policy that is enforced by the kernel is
dictated by security policy configuration files which include type
enforcement and role-based access control components.

The type enforcement component defines an extensible set of domains
and types.  Each process has an associated domain, and each object has
an associated type.  The configuration files specify how domains are
allowed to access types and to interact with other domains.  They specify
what types (when applied to programs) can be used to enter each domain
and the allowable transitions between domains.  They also specify
automatic transitions between domains when programs of certain types
are executed.  Such transitions ensure that system processes and
certain programs are placed into their own separate domains
automatically when executed.

The role-based access control component defines an extensible set of
roles.  Each process has an associated role.  This ensures that system
processes and those used for system administration can be separated
from those of ordinary users. The configuration files specify the set
of domains that may be entered by each role.  As users execute
programs, transitions to other domains may, according to the policy
configuration, automatically occur to support changes in privilege.

Using these security policy abstractions, it is possible to configure
the system to meet a wide range of security requirements. The release
includes an example of a general-purpose security policy configuration
designed to meet a number of security objectives as an example of how
this may be done. The flexibility of the system allows the policy to be
modified and extended to customize the security policy as required for
any given installation.

The example configuration controls access to various forms of raw data
and protects the integrity of the kernel.  It defines distinct types
for the boot files, module object files, module utilities, module
configuration files and sysctl parameters, and it defines separate
domains for processes that require write access to these files.  It
defines separate domains for the privileged module utilities, and it
restricts the use of the module capability to these domains.  It only
allows the administrator domain to transition to the privileged module
utility domains.

The example configuration protects the integrity of system software, system
configuration information and system logs. It defines distinct types
for system libraries and binaries to control access to these files.  It
only allows administrators to modify system software.  It defines
separate types for system configuration files and system logs and
defines separate domains for programs that require write access.

The example configuration seeks to confine the potential damage that
can be caused through the exploitation of a flaw in a process that
requires privileges, whether a system process or privilege-enhancing
(setuid or setgid) program.  The policy configuration places these
privileged system processes and programs into separate domains, with
each domain limited to only those permissions it requires.  Separate
types for objects are defined in the policy configuration as needed to
support least privilege for these domains. The configuration also
attempts to protect privileged processes from executing malicious
code.  The policy configuration defines an executable type for the
program executed by each privileged process and only allows transitions
to the privileged domain by executing that type.  When possible, it
limits privileged process domains to executing the initial program for
the domain, the system dynamic linker, and the system shared libraries.
The administrator domain is allowed to execute programs created by
administrators as well as system software, but not programs created by
ordinary users or system processes.

Other objectives of the example configuration include protecting the
administrator role and domain from being entered without user
authentication, and preventing ordinary user processes from interfering
with system processes or administrator processes by controlling the use
of procfs, ptrace and signaling.

The security-enhanced Linux prototype was developed in conjunction with
research partners from the Secure Execution Environments group at NAI
Labs, Secure Computing Corporation (SCC), and the Mitre Corporation.
Researchers at the NSA implemented the security architecture in the
major subsystems of the Linux kernel, including mandatory access
controls for operations on processes, files, and sockets. NAI Labs is
working with the NSA in further developing and configuring this
security-enhanced Linux system, including the development of additional
kernel mandatory access controls and the creation of a general purpose
security policy configuration.  The security policy configuration drew
from some preliminary configuration work by SCC as a starting point,
and it also drew from NAI Labs' prior Domain and Type Enforcement (DTE)
configuration work.  SCC, MITRE and NAI Labs are also assisting the NSA
in developing application security policies and enhanced utility
programs for the system.

There is still much work needed to develop a complete security
solution. In addition, due to resource limitations, we have not yet
been able to evaluate and optimize the performance of the security
mechanisms. The prototype was developed using the 2.2.12 kernel, and we
have not yet updated the system to the latest stable kernel release.
There is a version for 2.2.17, but it hasn't been thoroughly tested.
Currently, we only support the x86 architecture and have only been able
to test it on the Red Hat 6.1 distribution. As the system is still a
prototype, we are not looking for the patches to be adopted into Linux
2.2, or even 2.4. Instead, we are presenting the system as a starting
point for discussions about the possible inclusion of these valuable
security features into the 2.5 kernel series. We are looking forward to
building upon this work with the Linux community.

If you are interested in experimenting with the system or getting more
information about it, please visit our web site at
http://www.nsa.gov/selinux. This site contains the source to the system
as well as some technical documentation about it. We are currently
developing a FAQ that will also provide additional information. A
mailing list, selinux@tycho.nsa.gov, has been created for questions and
discussion.  Subscribe to the mailing list by sending mail to
Majordomo@tycho.nsa.gov with "subscribe selinux" as the body of the
message. We welcome your feedback.


Peter Loscocco
Security-enhanced Linux Project Leader
Information Assurance Research Office
National Security Agency
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
