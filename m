Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVDZC1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVDZC1B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 22:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVDZC1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 22:27:01 -0400
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:25355 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261284AbVDZC0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 22:26:07 -0400
Message-ID: <426DA6BC.9070703@hp.com>
Date: Mon, 25 Apr 2005 22:26:04 -0400
From: Stephen Langdon <steve.langdon@hp.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: Roland Dreier <roland@topspin.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       hch@infradead.org, Timur Tabi <timur.tabi@ammasso.com>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
 implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	<20050411142213.GC26127@kalmia.hozed.org>	<52mzs51g5g.fsf@topspin.com>	<20050411163342.GE26127@kalmia.hozed.org>	<5264yt1cbu.fsf@topspin.com>	<20050411180107.GF26127@kalmia.hozed.org>	<52oeclyyw3.fsf@topspin.com>	<20050411171347.7e05859f.akpm@osdl.org>	<4263DEC5.5080909@ammasso.com>	<20050418164316.GA27697@infradead.org>	<4263E445.8000605@ammasso.com>	<20050423194421.4f0d6612.akpm@osdl.org>	<426BABF4.3050205@ammasso.com> <52is2bvvz5.fsf@topspin.com>	<20050425135401.65376ce0.akpm@osdl.org>	<521x8yv9vb.fsf@topspin.com>	<20050425151459.1f5fb378.akpm@osdl.org>	<426D6D68.6040504@ammasso.com>	<20050425153256.3850ee0a.akpm@osdl.org>	<52vf6atnn8.fsf@topspin.com> <20050426020338.5909570488@sv1.valinux.co.jp>
In-Reply-To: <20050426020338.5909570488@sv1.valinux.co.jp>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms030003010805060503030203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms030003010805060503030203
Content-Type: multipart/mixed;
 boundary="------------060209050103070504000900"

This is a multi-part message in MIME format.
--------------060209050103070504000900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I don't think that we should jump to the conclusion that in the long 
term HPC users cannot benefit from support of mechanisms such as 
hotremoval of memory or other forms of page migration in physical 
memory.  In an earlier exchange on the openib-general list Mike Krause 
sent the message quoted below on very much the same topic.  On the other 
hand I am willing to accept that there is practical value to 
implementations which are not (yet) sophisticated to enough to support 
the migration functions.

Steve Langdon

> Michael Krause wrote: At 05:35 PM 3/14/2005, Caitlin Bestler wrote:
>
>>  
>>
>> > -----Original Message-----
>> > From: Troy Benjegerdes [ mailto:hozer@hozed.org]
>> > Sent: Monday, March 14, 2005 5:06 PM
>> > To: Caitlin Bestler
>> > Cc: openib-general@openib.org
>> > Subject: Re: [openib-general] Getting rid of pinned memory requirement
>> >
>> > >
>> > > The key is that the entire operation either has to be fast
>> > > enough so that no connection or application session layer
>> > > time-outs occur, or an end-to-end agreement to suspend the
>> > > connetion is a requirement. The first option seems more
>> > > plausible to me, the second essentially
>> > > reuqires extending the CM protocol. That's a tall order even for
>> > > InfiniBand, and it's even worse for iWARP where the CM
>> > > functionality typically ends when the connection is established.
>> > 
>> > I'll buy the good network design argument.
>
>
> I and others designed InfiniBand RNR (Receiver not ready) operations 
> to allow one to adjust V-to-P mappings (not change the address that 
> was advertised) in order to allow an OS to safely play some games with 
> memory and not drop a connection.  The time values associated with RNR 
> allow a solution to tolerate up to infinite amount of time to perform 
> such operations but the envisioned goal was to do this on the order of 
> a handful or milliseconds in the worse case.  For iWARP, there was no 
> support for defining RNR functionality as indeed many people claimed 
> one could just drop in-bound segments and allow the retransmission 
> protocol to deal with the delay (even if this has performance 
> implications due to back-off algorithms though some claim SACK would 
> minimize this to a large extent).  Again, the idea was to minimize the 
> worse case to milliseconds of down time.  BTW, all of this assumed 
> that the OS would not perform these types of changes that often so the 
> long-term impact on an application would be minimum.
>
>> >
>> > I suppose if the kernel wants to revoke a card's pinned
>> > memory, we should be able to guarantee that it gets new
>> > pinned memory within a bounded time. What sort of timing do
>> > we need? Milliseconds?
>> > Microseconds?
>> >
>> > In the case of iWarp, isn't this just TCP underneath? If so,
>> > can't we just drop any packets in the pipe on the floor and
>> > let them get retransmitted? (I suppose the same argument goes
>> > for infiniband..
>> > what sort of a time window do we have for retransmission?)
>> >
>> > What are the limits on end-to-end flow control in IB and iWarp?
>> >
>>
>> >From the RDMA Provider's perspective, the short answer is "quick 
>> enough so that I don't have to do anything heroic to keep the 
>> connection alive."
>
>
> It should not require anything heroic.  What is does require is a 
> local method to suspend the local QP(s) so that it cannot place or 
> read memory in the effected area.  That can take some time depending 
> upon the implementation.  There is then the time to over write the 
> mappings which again depending upon the implementation and the number 
> of mappings could be milliseconds in length.
>
>> With TCP you also have to add "and healthy". If you've ever had a 
>> long download that got effectively stalled by a burst of noise and 
>> you just hit the 'reload' button on your browser then you know what 
>> I'm talking about.
>>
>> But in transport neutral terms I would think that one RTT is 
>> definitely safe -- that much data could have
>> been dropped by one switch failure or one nasty spike in inbound noise.
>>
>> > >
>> > > Yes, there are limits on how much memory you can mlock, or even
>> > > allocate. Applications are required to reqister memory precisely
>> > > because the required guarantess are not there by default.
>> > Eliminating
>> > > those guarantees *is* effectively rewriting every RDMA application
>> > > without even letting them know.
>> >
>> > Some of this argument is a policy issue, which I would argue
>> > shouldn't be hard-coded in the code or in the network hardware.
>> >
>> > At least in my view, the guarantees are only there to make
>> > applications go fast. We are getting low latency and high
>> > performance with infiniband by making memory registration go
>> > really really slow. If, to make big HPC simulation
>> > applications work, we wind up doing memcpy() to put the data
>> > into a registered buffer because we can't register half of
>> > physical memory, the application isn't going very fast.
>> >
>>
>> What you are looking for is a distinction between registering
>> memory to *enable* the RNIC to optimize local access and
>> registering memory to enable its being advertised to the
>> remote end.
>>
>> Early implementations of RDMA, both IB and iWARP, have not
>> distinquished between the two. But theoretically *applications*
>> do not need memory regions that are not enabled for remote
>> access to be pinned. That is an RNIC requirement that could
>> evolve. But applications themselves *do* need remotely
>> accessible memory regions, portions of which they intend
>> to advertise with RKeys, to be truly available (i.e., pinned).
>>
>> You are also making a policy assumption that an application
>> that actually needs half of physical memory should be using
>> paged memory. Memory is cheap, and if performance is critical
>> why should this memory be swapped out to disk?
>>
>> Is the limitation on not being able to register half of
>> physical memory based upon some assumption that swapping
>> is a requirement? Or is it a limitation in the memory region
>> size? If it's the latter, you need to get the OS to support
>> larger page sizes.
>
>
> For some OS, you can pin very large areas.  I've seen 15/16 of memory 
> being able to be pinned with no adverse impacts on the applications.  
> For these OS, kernel memory is effectively pinned memory.  As such, 
> depending upon the mix of services being provided, the system may 
> operate quite nicely with such large amounts of memory being pinned.  
> As more services are "ported" to operate over RDMA technologies, 
> memory management isn't necessarily any harder; it just becomes 
> something people have to think more about.  Today's VM designs have 
> allowed people to get sloppy as they assume that swapping will occur 
> and since many platforms are not that loaded, they don't see any real 
> adverse impacts.  User-space RDMA applications requires people to 
> think once again about memory management and that swapping isn't a 
> get-out-of-jail card.  One needs to develop resource management tools 
> to determine who obtains specified amounts of resources and their 
> priorities.  For the most part, this is somewhat a re-invention of 
> some thinking that went into the micro-kernel work in past years.  
> These problems are not intractable; they are only constrained by the 
> legacy inertia inherent in all technologies today.
>
> Mike
>
>  
>



IWAMOTO Toshihiro wrote:

>At Mon, 25 Apr 2005 16:58:03 -0700,
>Roland Dreier wrote:
>  
>
>>    Andrew> It would be better to obtain this memory via a mmap() of
>>    Andrew> some special device node, so we can perform appropriate
>>    Andrew> permission checking and clean everything up on unclean
>>    Andrew> application exit.
>>
>>This seems to interact poorly with how applications want to use RDMA,
>>ie typically through a library interface such as MPI.  People doing
>>HPC don't want to recode their apps to use a new allocator, they just
>>want to link to a new MPI library and have the app go fast.
>>    
>>
>
>Such HPC users cannot use the memory hotremoval feature, and something
>needs to be implemented so that the NUMA migration can handle such
>memory properly, but I see your point.
>
>If such memory were allocated by a driver, the memory could be placed
>in non-hotremovable areas to avoid the above problems.
>
>--
>IWAMOTO Toshihiro
>_______________________________________________
>openib-general mailing list
>openib-general@openib.org
>http://openib.org/mailman/listinfo/openib-general
>
>To unsubscribe, please visit http://openib.org/mailman/listinfo/openib-general
>  
>


--------------060209050103070504000900
Content-Type: text/x-vcard; charset=utf-8;
 name="steve.langdon.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="steve.langdon.vcf"

begin:vcard
fn:Steve Langdon
n:Langdon;Stephen
org:Hewlett-Packard;Consulting & Architecture Group
adr:MS LKG1-3/B19;;550 King Street;Littleton;MA;01460;USA
email;internet:steve.langdon@hp.com
title:Fellow
tel;work:+1 978-506-5771
tel;fax:+1 978-742-1144
tel;home:+1 978-456-8177
tel;cell:+1 978-618-8599
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------060209050103070504000900--

--------------ms030003010805060503030203
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIITATCC
BCUwggOOoAMCAQICEFY7bue2cS6UAM17nmK17pQwDQYJKoZIhvcNAQEFBQAwgcExCzAJBgNV
BAYTAlVTMRcwFQYDVQQKEw5WZXJpU2lnbiwgSW5jLjE8MDoGA1UECxMzQ2xhc3MgMiBQdWJs
aWMgUHJpbWFyeSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAtIEcyMTowOAYDVQQLEzEoYykg
MTk5OCBWZXJpU2lnbiwgSW5jLiAtIEZvciBhdXRob3JpemVkIHVzZSBvbmx5MR8wHQYDVQQL
ExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMB4XDTAxMDQyNDAwMDAwMFoXDTA5MDQyMzIzNTk1
OVowgeIxIDAeBgNVBAoTF0hld2xldHQtUGFja2FyZCBDb21wYW55MR8wHQYDVQQLExZWZXJp
U2lnbiBUcnVzdCBOZXR3b3JrMTswOQYDVQQLEzJUZXJtcyBvZiB1c2UgYXQgaHR0cHM6Ly93
d3cudmVyaXNpZ24uY29tL3JwYSAoYykwMTEwMC4GA1UECxMnQ2xhc3MgMiBPblNpdGUgSW5k
aXZpZHVhbCBTdWJzY3JpYmVyIENBMS4wLAYDVQQDEyVDb2xsYWJvcmF0aW9uIENlcnRpZmlj
YXRpb24gQXV0aG9yaXR5MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDAcFMLBRNrSFto
eiDpMyfh4Tvf3wSPPCAzr0c/4ruQ3JV8VamHbqoEgNgBkt5sJi0YhvuT3JOY9FUhYB1gODDb
y1D5Dxt6WCoRabDOa/0hJOUSAW84Uspz5yAj38UoKJE3ZBbXa4ey6AmEoHA0nbXMHswOgR0G
MZjUzJjlPX7lOwIDAQABo4H6MIH3MA8GA1UdEwQIMAYBAf8CAQAwRAYDVR0gBD0wOzA5Bgtg
hkgBhvhFAQcBATAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy52ZXJpc2lnbi5jb20vcnBh
MAsGA1UdDwQEAwIBBjARBglghkgBhvhCAQEEBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNV
BAMTEVByaXZhdGVMYWJlbDEtMzgyMDQGA1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwudmVy
aXNpZ24uY29tL3BjYTItZzIuY3JsMB0GA1UdDgQWBBTv7SDNQ0Ufg0dgFZZDckrkxsznPTAN
BgkqhkiG9w0BAQUFAAOBgQBBklFcgEBo2ZBUa4XrycoQyF1r9aXnqu+T0C4diQpXSw//2S27
Kfsoy4cqIWPi4ArAJkuKrfrCNiqIreOCT0xnlM+QC5/VPJYnUyqegWfr7tZxCT+V4nBtUNO0
pXtPRt9M/x8YXntxXyonpJJaJ+kOx5h0qH4KeM/WQjeOQtMnbzCCB2gwggbRoAMCAQICEAcZ
V0Hdk2cE/16oHcE5ATUwDQYJKoZIhvcNAQEFBQAwgeIxIDAeBgNVBAoTF0hld2xldHQtUGFj
a2FyZCBDb21wYW55MR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTswOQYDVQQL
EzJUZXJtcyBvZiB1c2UgYXQgaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL3JwYSAoYykwMTEw
MC4GA1UECxMnQ2xhc3MgMiBPblNpdGUgSW5kaXZpZHVhbCBTdWJzY3JpYmVyIENBMS4wLAYD
VQQDEyVDb2xsYWJvcmF0aW9uIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA0MDcyNDAw
MDAwMFoXDTA2MDcyNDIzNTk1OVowgZgxIDAeBgNVBAoUF0hld2xldHQtUGFja2FyZCBDb21w
YW55MSYwJAYDVQQLFB1FbXBsb3ltZW50IFN0YXR1cyAtIEVtcGxveWVlczEPMA0GA1UECxQG
Uy9NSU1FMRYwFAYDVQQDEw1TdGV2ZSBMYW5nZG9uMSMwIQYJKoZIhvcNAQkBFhRzdGV2ZS5s
YW5nZG9uQGhwLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKyoQj4wOn8h
s7Aq2EhKBf15cXYZ9wGkcst0xBMzvVFd/0YHImnKlS/uAKRVwx1IurXXwvX7l2jJV8o9qOYe
rs5xdiKvIRA9A/MfulTAy6yz1cMQJGCmJQRt68bmCZXGYzSJzHr51Y2pQYkbkUi1qV+tQ6QQ
6ZraydptnvTzVAkXwllSGuV8NUBtnZmzfMw1slG+j0MyjQOSs9magshHuLeaS9PwPag1lK6t
oT24fB6CaraiPGd8gGwp5h5e5hd658PRko3OLsHwxSnS5XbXhpHK6NUj39CUEIflH4pKB+9d
PTiLrO3ByEaqZNdCgZIaruvL6jNR3IJJRvWwITsNlzsCAwEAAaOCA+EwggPdMEcGA1UdEQRA
MD6BFHN0ZXZlLmxhbmdkb25AaHAuY29tgQ5sYW5nZG9uQGhwLmNvbYEWc3RlcGhlbi5sYW5n
ZG9uQGhwLmNvbTAMBgNVHRMBAf8EAjAAMA4GA1UdDwEB/wQEAwIFoDAfBgNVHSMEGDAWgBTv
7SDNQ0Ufg0dgFZZDckrkxsznPTAdBgNVHQ4EFgQUAtHaaa1reZL8jqvrPC7WfqLqY8UwVwYD
VR0fBFAwTjBMoEqgSIZGaHR0cDovL29uc2l0ZWNybC52ZXJpc2lnbi5jb20vSGV3bGV0dFBh
Y2thcmRDb21wYW55U01JTUUvTGF0ZXN0Q1JMLmNybDAWBgNVHSUBAf8EDDAKBggrBgEFBQcD
BDCCAT0GA1UdIASCATQwggEwMIIBLAYLYIZIAYb4RQEHFwIwggEbMCgGCCsGAQUFBwIBFhxo
dHRwczovL3d3dy52ZXJpc2lnbi5jb20vQ1BTMIHuBggrBgEFBQcCAjCB4TAeFhdIZXdsZXR0
LVBhY2thcmQgQ29tcGFueTADAgECGoG+QXV0aG9yaXR5IHRvIGJpbmQgSFAgZG9lcyBub3Qg
Y29ycmVzcG9uZCB3aXRoIHVzZSBvciBwb3NzZXNzaW9uIG9mIHRoaXMgY2VydGlmaWNhdGUu
IElzc3VlZCB0byBmYWNpbGl0YXRlIGNvbW11bmljYXRpb24gd2l0aCBIUC4gVmVyaVNpZ24n
cyBDUFMgaW5jb3JwLiBCeSByZWZlcmVuY2UgbGlhYi4gbHRkLiAoYyk5NyBWZXJpU2lnbjCC
ATMGCCsGAQUFBwEBBIIBJTCCASEwKwYIKwYBBQUHMAGGH2h0dHA6Ly9vbnNpdGUtb2NzcC52
ZXJpc2lnbi5jb20wgfEGCCsGAQUFBzACpIHkMIHhMS4wLAYDVQQDEyVDb2xsYWJvcmF0aW9u
IENlcnRpZmljYXRpb24gQXV0aG9yaXR5MTAwLgYDVQQLEydDbGFzcyAyIE9uU2l0ZSBJbmRp
dmlkdWFsIFN1YnNjcmliZXIgQ0ExOjA4BgNVBAsTMVRlcm1zIG9mIHVzZSBhdCBodHRwczov
L3d3dy52ZXJpc2lnbi5jb20vcnBhKGMpMDExHzAdBgNVBAsTFlZlcmlTaWduIFRydXN0IE5l
dHdvcmsxIDAeBgNVBAoTF0hld2xldHQtUGFja2FyZCBDb21wYW55MEsGCSqGSIb3DQEJDwQ+
MDwwDgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMCAgIAQDAOBggqhkiG9w0DBAICAIAwCgYI
KoZIhvcNAwcwDQYJKoZIhvcNAQEFBQADgYEAV2CT1O1Tc5JcbJSlCPM2tTEaWMunwRRbdKR4
0qCy51ON3GN0eMAc5Q0agFpaeUJET9KlM1+gmBEhQNMBm7GDWn0eW/mzE+eRr1pcE0vpozs2
c0/gEHTylsWjINn2nWKciOCAmI8JS3cu1CpGwo6MghnffeLnkC7HgC4sVtbK3qAwggdoMIIG
0aADAgECAhAHGVdB3ZNnBP9eqB3BOQE1MA0GCSqGSIb3DQEBBQUAMIHiMSAwHgYDVQQKExdI
ZXdsZXR0LVBhY2thcmQgQ29tcGFueTEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29y
azE7MDkGA1UECxMyVGVybXMgb2YgdXNlIGF0IGh0dHBzOi8vd3d3LnZlcmlzaWduLmNvbS9y
cGEgKGMpMDExMDAuBgNVBAsTJ0NsYXNzIDIgT25TaXRlIEluZGl2aWR1YWwgU3Vic2NyaWJl
ciBDQTEuMCwGA1UEAxMlQ29sbGFib3JhdGlvbiBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAe
Fw0wNDA3MjQwMDAwMDBaFw0wNjA3MjQyMzU5NTlaMIGYMSAwHgYDVQQKFBdIZXdsZXR0LVBh
Y2thcmQgQ29tcGFueTEmMCQGA1UECxQdRW1wbG95bWVudCBTdGF0dXMgLSBFbXBsb3llZXMx
DzANBgNVBAsUBlMvTUlNRTEWMBQGA1UEAxMNU3RldmUgTGFuZ2RvbjEjMCEGCSqGSIb3DQEJ
ARYUc3RldmUubGFuZ2RvbkBocC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQCsqEI+MDp/IbOwKthISgX9eXF2GfcBpHLLdMQTM71RXf9GByJpypUv7gCkVcMdSLq118L1
+5doyVfKPajmHq7OcXYiryEQPQPzH7pUwMuss9XDECRgpiUEbevG5gmVxmM0icx6+dWNqUGJ
G5FItalfrUOkEOma2snabZ7081QJF8JZUhrlfDVAbZ2Zs3zMNbJRvo9DMo0DkrPZmoLIR7i3
mkvT8D2oNZSuraE9uHwegmq2ojxnfIBsKeYeXuYXeufD0ZKNzi7B8MUp0uV214aRyujVI9/Q
lBCH5R+KSgfvXT04i6ztwchGqmTXQoGSGq7ry+ozUdyCSUb1sCE7DZc7AgMBAAGjggPhMIID
3TBHBgNVHREEQDA+gRRzdGV2ZS5sYW5nZG9uQGhwLmNvbYEObGFuZ2RvbkBocC5jb22BFnN0
ZXBoZW4ubGFuZ2RvbkBocC5jb20wDAYDVR0TAQH/BAIwADAOBgNVHQ8BAf8EBAMCBaAwHwYD
VR0jBBgwFoAU7+0gzUNFH4NHYBWWQ3JK5MbM5z0wHQYDVR0OBBYEFALR2mmta3mS/I6r6zwu
1n6i6mPFMFcGA1UdHwRQME4wTKBKoEiGRmh0dHA6Ly9vbnNpdGVjcmwudmVyaXNpZ24uY29t
L0hld2xldHRQYWNrYXJkQ29tcGFueVNNSU1FL0xhdGVzdENSTC5jcmwwFgYDVR0lAQH/BAww
CgYIKwYBBQUHAwQwggE9BgNVHSAEggE0MIIBMDCCASwGC2CGSAGG+EUBBxcCMIIBGzAoBggr
BgEFBQcCARYcaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL0NQUzCB7gYIKwYBBQUHAgIwgeEw
HhYXSGV3bGV0dC1QYWNrYXJkIENvbXBhbnkwAwIBAhqBvkF1dGhvcml0eSB0byBiaW5kIEhQ
IGRvZXMgbm90IGNvcnJlc3BvbmQgd2l0aCB1c2Ugb3IgcG9zc2Vzc2lvbiBvZiB0aGlzIGNl
cnRpZmljYXRlLiBJc3N1ZWQgdG8gZmFjaWxpdGF0ZSBjb21tdW5pY2F0aW9uIHdpdGggSFAu
IFZlcmlTaWduJ3MgQ1BTIGluY29ycC4gQnkgcmVmZXJlbmNlIGxpYWIuIGx0ZC4gKGMpOTcg
VmVyaVNpZ24wggEzBggrBgEFBQcBAQSCASUwggEhMCsGCCsGAQUFBzABhh9odHRwOi8vb25z
aXRlLW9jc3AudmVyaXNpZ24uY29tMIHxBggrBgEFBQcwAqSB5DCB4TEuMCwGA1UEAxMlQ29s
bGFib3JhdGlvbiBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEwMC4GA1UECxMnQ2xhc3MgMiBP
blNpdGUgSW5kaXZpZHVhbCBTdWJzY3JpYmVyIENBMTowOAYDVQQLEzFUZXJtcyBvZiB1c2Ug
YXQgaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL3JwYShjKTAxMR8wHQYDVQQLExZWZXJpU2ln
biBUcnVzdCBOZXR3b3JrMSAwHgYDVQQKExdIZXdsZXR0LVBhY2thcmQgQ29tcGFueTBLBgkq
hkiG9w0BCQ8EPjA8MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DAgICAEAwDgYIKoZIhvcN
AwQCAgCAMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBBQUAA4GBAFdgk9TtU3OSXGyUpQjzNrUx
GljLp8EUW3SkeNKgsudTjdxjdHjAHOUNGoBaWnlCRE/SpTNfoJgRIUDTAZuxg1p9Hlv5sxPn
ka9aXBNL6aM7NnNP4BB08pbFoyDZ9p1inIjggJiPCUt3LtQqRsKOjIIZ333i55Aux4AuLFbW
yt6gMYIE7jCCBOoCAQEwgfcwgeIxIDAeBgNVBAoTF0hld2xldHQtUGFja2FyZCBDb21wYW55
MR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTswOQYDVQQLEzJUZXJtcyBvZiB1
c2UgYXQgaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL3JwYSAoYykwMTEwMC4GA1UECxMnQ2xh
c3MgMiBPblNpdGUgSW5kaXZpZHVhbCBTdWJzY3JpYmVyIENBMS4wLAYDVQQDEyVDb2xsYWJv
cmF0aW9uIENlcnRpZmljYXRpb24gQXV0aG9yaXR5AhAHGVdB3ZNnBP9eqB3BOQE1MAkGBSsO
AwIaBQCgggLLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1
MDQyNjAyMjYwNFowIwYJKoZIhvcNAQkEMRYEFK26f4zNVhLfBnqpSBayn0M6bMriMFIGCSqG
SIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIIBCAYJKwYBBAGCNxAEMYH6MIH3MIHiMSAwHgYD
VQQKExdIZXdsZXR0LVBhY2thcmQgQ29tcGFueTEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3Qg
TmV0d29yazE7MDkGA1UECxMyVGVybXMgb2YgdXNlIGF0IGh0dHBzOi8vd3d3LnZlcmlzaWdu
LmNvbS9ycGEgKGMpMDExMDAuBgNVBAsTJ0NsYXNzIDIgT25TaXRlIEluZGl2aWR1YWwgU3Vi
c2NyaWJlciBDQTEuMCwGA1UEAxMlQ29sbGFib3JhdGlvbiBDZXJ0aWZpY2F0aW9uIEF1dGhv
cml0eQIQBxlXQd2TZwT/XqgdwTkBNTCCAQoGCyqGSIb3DQEJEAILMYH6oIH3MIHiMSAwHgYD
VQQKExdIZXdsZXR0LVBhY2thcmQgQ29tcGFueTEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3Qg
TmV0d29yazE7MDkGA1UECxMyVGVybXMgb2YgdXNlIGF0IGh0dHBzOi8vd3d3LnZlcmlzaWdu
LmNvbS9ycGEgKGMpMDExMDAuBgNVBAsTJ0NsYXNzIDIgT25TaXRlIEluZGl2aWR1YWwgU3Vi
c2NyaWJlciBDQTEuMCwGA1UEAxMlQ29sbGFib3JhdGlvbiBDZXJ0aWZpY2F0aW9uIEF1dGhv
cml0eQIQBxlXQd2TZwT/XqgdwTkBNTANBgkqhkiG9w0BAQEFAASCAQAb37B0ErYg1Sswg/j0
f85/Js3Ce6bTitvuvxaPxaR+tUaffqYT3d+V6eH0rLz+cIQ5PuPLARx/jNZo5Qd/UtN8DVW0
kzqhLIiaUqCViavKX83pxVPM5kNlk98RkCn5wgmeNTQ0glekF45ccT1csIxHECiTeqPTO06R
fjFlTBhBQaEBygvGFdfvQ69M09Tvy9YeLUREyP7GSPwHmBaeSL79nL4VdT1oApysERumMANs
i7IH/nNAqOkfA7W7VsYHDLW829arhyhGm+/taRnayCbqJbJ+DmYlK+OiE/2UrIgFHXG43fJI
5yJ4uiOaDT/jmX9XDklvD0DpbRVEicxH7tWhAAAAAAAA
--------------ms030003010805060503030203--
